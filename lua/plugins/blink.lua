local function get_icon(ctx)
  local mini_icons = require "mini.icons"
  local source = ctx.item.source_name
  local label = ctx.item.label
  local color = ctx.item.documentation

  if source == "LSP" then
    if color and type(color) == "string" and color:match "^#%x%x%x%x%x%x$" then
      local hl = "hex-" .. color:sub(2)
      if #vim.api.nvim_get_hl(0, { name = hl }) == 0 then vim.api.nvim_set_hl(0, hl, { fg = color }) end
      return "󱓻", hl, false
    else
      return mini_icons.get("lsp", ctx.kind)
    end
  elseif source == "Path" then
    return (label:match "%.[^/]+$" and mini_icons.get("file", label) or mini_icons.get("directory", label))
  elseif source == "codeium" then
    return mini_icons.get("lsp", "event")
  else
    return ctx.kind_icon, "BlinkCmpKind" .. ctx.kind, false
  end
end

return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  version = "*",
  dependencies = {
    { "rafamadriz/friendly-snippets", lazy = true },
    "echasnovski/mini.icons",
  },
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },
  opts = {
    snippets = {
      expand = function(snippet, _) return require("utils").expand(snippet) end,
    },
    -- remember to enable your providers here
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        lsp = {
          ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[])
          transform_items = function(ctx, items)
            for _, item in ipairs(items) do
              if item.kind == require("blink.cmp.types").CompletionItemKind.Snippet then
                item.score_offset = item.score_offset - 3
              end
            end

            ---@diagnostic disable-next-line: redundant-return-value
            return vim.tbl_filter(function(item)
              local c = ctx.get_cursor()
              local cursor_line = ctx.line
              local cursor = {
                row = c[1],
                col = c[2] + 1,
                line = c[1] - 1,
              }
              local cursor_before_line = string.sub(cursor_line, 1, cursor.col - 1)

              -- remove text
              if item.kind == require("blink.cmp.types").CompletionItemKind.Text then return false end

              if vim.bo.filetype == "vue" then
                -- For events
                if cursor_before_line:match "(@[%w]*)%s*$" ~= nil then
                  return item.label:match "^@" ~= nil
                  -- For props also exclude events with `:on-` prefix
                elseif cursor_before_line:match "(:[%w]*)%s*$" ~= nil then
                  return item.label:match "^:" ~= nil and not item.label:match "^:on%-" ~= nil
                  -- For slot
                elseif cursor_before_line:match "(#[%w]*)%s*$" ~= nil then
                  return item.kind == require("blink.cmp.types").CompletionItemKind.Method
                end
              end

              return true
            end, items)
          end,
        },
      },
    },
    keymap = {
      ["<C-P>"] = { "select_prev", "fallback" },
      ["<C-N>"] = { "select_next", "fallback" },
      ["<C-U>"] = { "scroll_documentation_up", "fallback" },
      ["<C-D>"] = { "scroll_documentation_down", "fallback" },
      ["<C-E>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },
    appearance = {
      -- sets the fallback highlight groups to nvim-cmp's highlight groups
      -- useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release, assuming themes add support
      use_nvim_cmp_as_default = false,
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },
    signature = {
      enabled = true,
      trigger = {
        blocked_trigger_characters = {},
        blocked_retrigger_characters = {},
        -- When true, will show the signature help window when the cursor comes after a trigger character when entering insert mode
        show_on_insert_on_trigger_character = true,
      },
      window = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
      },
    },
    completion = {
      menu = {
        draw = {
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = function(ctx) return require("colorful-menu").blink_components_text(ctx) end,
              highlight = function(ctx) return require("colorful-menu").blink_components_highlight(ctx) end,
            },
          },
        },
        scrollbar = false,
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      },
      -- Disable auto brackets
      -- NOTE: some LSPs may add auto brackets themselves anyway
      accept = {
        auto_brackets = { enabled = true },
      },
      -- Insert completion item on selection, don't select by default
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
          scrollbar = false,
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        },
      },
      ghost_text = {
        enabled = false,
      },
    },
  },
  ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
  config = function(_, opts)
    -- setup compat sources
    local enabled = opts.sources.default
    for _, source in ipairs(opts.sources.compat or {}) do
      opts.sources.providers[source] = vim.tbl_deep_extend(
        "force",
        { name = source, module = "blink.compat.source" },
        opts.sources.providers[source] or {}
      )
      if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then table.insert(enabled, source) end
    end

    -- Unset custom prop to pass blink.cmp validation
    opts.sources.compat = nil

    -- check if we need to override symbol kinds
    for _, provider in pairs(opts.sources.providers or {}) do
      ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
      if provider.kind then
        local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
        local kind_idx = #CompletionItemKind + 1

        CompletionItemKind[kind_idx] = provider.kind
        ---@diagnostic disable-next-line: no-unknown
        CompletionItemKind[provider.kind] = kind_idx

        ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
        local transform_items = provider.transform_items
        ---@param ctx blink.cmp.Context
        ---@param items blink.cmp.CompletionItem[]
        provider.transform_items = function(ctx, items)
          items = transform_items and transform_items(ctx, items) or items
          for _, item in ipairs(items) do
            item.kind = kind_idx or item.kind
          end
          return items
        end

        -- Unset custom prop to pass blink.cmp validation
        provider.kind = nil
      end
    end

    require("blink.cmp").setup(opts)
  end,
  specs = {
    {
      "AstroNvim/astrolsp",
      ---@type AstroLSPOpts
      opts = function(_, opts)
        local has_blink, blink = pcall(require, "blink.cmp")
        local capabilities =
          vim.tbl_deep_extend("force", {}, opts.capabilities or {}, has_blink and blink.get_lsp_capabilities() or {})
        -- disable AstroLSP signature help if `blink.cmp` is providing it
        local blink_opts = require("astrocore").plugin_opts "blink.cmp"
        local signature_help = true
        if vim.tbl_get(blink_opts, "signature", "enabled") == true then signature_help = false end
        return require("astrocore").extend_tbl(
          opts,
          { capabilities = capabilities, features = {
            signature_help = signature_help,
          } }
        )
      end,
    },
    {
      "folke/lazydev.nvim",
      optional = true,
      specs = {
        {
          "Saghen/blink.cmp",
          opts = function(_, opts)
            if pcall(require, "lazydev.integrations.blink") then
              return require("astrocore").extend_tbl(opts, {
                sources = {
                  -- add lazydev to your completion providers
                  default = { "lazydev" },
                  providers = {
                    lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
                  },
                },
              })
            end
          end,
        },
      },
    },
    -- disable built in completion plugins
    { "hrsh7th/nvim-cmp", enabled = false },
    { "rcarriga/cmp-dap", enabled = false },
    { "petertriho/cmp-git", enabled = false },
    { "L3MON4D3/LuaSnip", enabled = false },
    { "onsails/lspkind.nvim", enabled = false },
  },
}
