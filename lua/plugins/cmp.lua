local function mapping()
  local cmp = require "cmp"
  local luasnip = require "luasnip"

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
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }
end

---@type LazySpec
return {
  "hrsh7th/nvim-cmp",
  specs = {
    "AstroNvim/astroui",
  },
  opts = function(_, opts)
    local compare = require "cmp.config.compare"

    return require("astrocore").extend_tbl(opts, {
      sorting = {
        comparators = {
          compare.offset,
          compare.exact,
          compare.score,
          compare.recently_used,
          compare.kind,
          compare.sort_text,
          compare.length,
          compare.order,
        },
      },
      completion = {
        completeopt = "menu,menuone,preview,noinsert",
      },
      mapping = mapping(),
      experimental = {
        ghost_text = true,
      },
      formatting = {
        expandable_indicator = true,
        format = function(entry, item)
          local str = require "cmp.utils.str"
          local widths = {
            abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 30,
            menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
          }
          for key, width in pairs(widths) do
            if item[key] and vim.fn.strdisplaywidth(str.trim(item[key])) > width then
              item[key] = vim.fn.strcharpart(str.trim(item[key]), 0, width - 1) .. "…"
            end
          end

          local icon, hl, _ = require("mini.icons").get("lsp", item.kind or "")
          item.abbr = item.abbr
          item.kind = " " .. icon .. " "
          item.kind_hl_group = "CmpMini" .. hl

          return item
        end,

        fields = { "kind", "abbr", "menu" },
      },
      window = {
        completion = {
          col_offset = 0,
          side_padding = 0,
          scrollbar = false,
          winhighlight = "Normal:CmpDocumentation,CursorLine:PmenuSel,Search:None,FloatBorder:CmpDocumentationBorder",
          border = "none",
        },
        documentation = {
          border = "none",
          winhighlight = "Normal:CmpDocumentation,FloatBorder:CmpDocumentationBorder",
        },
      },
    })
  end,
}
