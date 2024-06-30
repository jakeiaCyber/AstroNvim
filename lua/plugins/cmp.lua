return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    local lspkind = require "lspkind"
    local function has_words_before()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end
    -- NOTE: this function does not merge in place and needs to be
    --       returned at the end of the function
    return require("astrocore").extend_tbl(opts, {
      mapping = {
        ["<CR>"] = cmp.config.disable,
        ["<A-n>"] = cmp.mapping(function()
          if luasnip.jumpable(1) then luasnip.jump(1) end
        end, { "i", "s" }),
        ["<A-p>"] = cmp.mapping(function()
          if luasnip.jumpable(-1) then luasnip.jump(-1) end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(
          function() cmp.select_prev_item { behavior = cmp.SelectBehavior.Select } end,
          { "i", "s" }
        ),
        ["<C-j>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
          else
            cmp.complete()
          end
        end, { "i", "s" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.confirm { select = true }
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.config.disable,
      },
      completion = {
        completeopt = "menu,menuone,preview,noinsert",
      },
      experimental = {
        ghost_text = false,
      },
      window = {
        completion = cmp.config.window.bordered {
          border = {
            { "󱐋", "WarningMsg" },
            { "─", "Comment" },
            { "╮", "Comment" },
            { "│", "Comment" },
            { "╯", "Comment" },
            { "─", "Comment" },
            { "╰", "Comment" },
            { "│", "Comment" },
          },
        },
        documentation = cmp.config.window.bordered {
          border = {
            { "", "DiagnosticHint" },
            { "─", "Comment" },
            { "╮", "Comment" },
            { "│", "Comment" },
            { "╯", "Comment" },
            { "─", "Comment" },
            { "╰", "Comment" },
            { "│", "Comment" },
          },
        },
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format {
          mode = "symbol_text",
          preset = "codicons",
          before = function(entry, vim_item)
            if vim.tbl_contains({ "path" }, entry.source.name) then
              local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
              if icon then
                vim_item.kind = icon
                vim_item.kind_hl_group = hl_group
                return vim_item
              end
            end
            vim_item.menu = ({
              nvim_lsp = "(LSP)",
              buffer = "(Buffer)",
              path = "(Path)",
              luasnip = "(Snippets)",
              calc = "(Calc)",
            })[entry.source.name]

            vim_item.dup = ({
              buffer = 1,
              path = 1,
              nvim_lsp = 0,
              snippets = 1,
            })[entry.source.name] or 0
            return vim_item
          end,
        },
      },
    })
  end,
}
