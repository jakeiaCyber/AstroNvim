local function mapping()
  local cmp = require "cmp"

  return {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),

    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }
end

local function trim(s)
  if s == nil then return "" end
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

local function truncateString(s, maxLength)
  if #s > maxLength then
    return string.sub(s, 1, maxLength) .. "..."
  else
    return s
  end
end

local function getMethodName(s) return string.gsub(s, "%(.*%)", "") end

local formatting_style = {
  fields = { "abbr", "menu", "kind" },
  format = function(_, item)
    local icons = require "icons.lspkind"
    local icon = icons[item.kind] or ""
    item.kind = string.format("%s %s ", icon, trim(item.kind))
    item.abbr = getMethodName(trim(item.abbr))
    item.menu = truncateString(trim(item.menu), 10)
    return item
  end,
}

---@type LazySpec
return {
  "hrsh7th/nvim-cmp",
  specs = {
    -- {
    --   "hrsh7th/cmp-cmdline",
    --   keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
    --   opts = function()
    --     local cmp = require "cmp"
    --     return {
    --       {
    --         type = "/",
    --         mapping = mapping(),
    --         sources = {
    --           { name = "buffer" },
    --         },
    --       },
    --       {
    --         type = ":",
    --         mapping = mapping(),
    --         sources = cmp.config.sources({
    --           { name = "path" },
    --         }, {
    --           {
    --             name = "cmdline",
    --             option = {
    --               ignore_cmds = { "Man", "!" },
    --             },
    --           },
    --         }),
    --       },
    --     }
    --   end,
    --   config = function(_, opts)
    --     local cmp = require "cmp"
    --     vim.tbl_map(function(val) cmp.setup.cmdline(val.type, val) end, opts)
    --   end,
    -- },
  },
  dependencies = {
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",
    "jc-doyle/cmp-pandoc-references",
    "kdheepak/cmp-latex-symbols",
  },
  opts = function(_, opts)
    local cmp = require "cmp"
    local compare = require "cmp.config.compare"

    return require("astrocore").extend_tbl(opts, {
      formatting = formatting_style,
      sources = cmp.config.sources {
        {
          name = "nvim_lsp",
          ---@param entry cmp.Entry
          ---@param ctx cmp.Context
          entry_filter = function(entry, ctx)
            -- Check if the buffer type is 'vue'
            if ctx.filetype ~= "vue" then return true end

            local cursor_before_line = ctx.cursor_before_line
            -- For events
            if cursor_before_line:sub(-1) == "@" then
              return entry.completion_item.label:match "^@"
              -- For props also exclude events with `:on-` prefix
            elseif cursor_before_line:sub(-1) == ":" then
              return entry.completion_item.label:match "^:" and not entry.completion_item.label:match "^:on-"
            else
              return true
            end
          end,
          option = { markdown_oxide = { keyword_pattern = [[\(\k\| \|\/\|#\)\+]] } },
          priority = 1000,
        },
        { name = "luasnip", priority = 750 },
        { name = "pandoc_references", priority = 725 },
        { name = "latex_symbols", priority = 700 },
        { name = "emoji", priority = 700 },
        { name = "calc", priority = 650 },
        { name = "path", priority = 500 },
        { name = "buffer", priority = 250 },
      },
      sorting = {
        comparators = {
          compare.offset,
          compare.exact,
          compare.score,
          compare.recently_used,
          function(entry1, entry2)
            local _, entry1_under = entry1.completion_item.label:find "^_+"
            local _, entry2_under = entry2.completion_item.label:find "^_+"
            entry1_under = entry1_under or 0
            entry2_under = entry2_under or 0
            if entry1_under > entry2_under then
              return false
            elseif entry1_under < entry2_under then
              return true
            end
          end,
          compare.kind,
          compare.sort_text,
          compare.length,
          compare.order,
        },
      },
      completion = {
        -- auto select first item
        completeopt = "menu,menuone,preview,noinsert",
      },
      mapping = mapping(),
      window = {
        completion = {
          col_offset = 1,
          side_padding = 1,
          scrollbar = false,
        },
      },
      experimental = {
        ghost_text = true,
      },
    })
  end,
}
