local function tailwind(entry, item)
  local entryItem = entry:get_completion_item()
  local color = entryItem.documentation
  if color and type(color) == "string" and color:match "^#%x%x%x%x%x%x$" then
    local hl = "hex-" .. color:sub(2)
    if #vim.api.nvim_get_hl(0, { name = hl }) == 0 then vim.api.nvim_set_hl(0, hl, { fg = color }) end
    item.kind = " 󱓻 "
    item.kind_hl_group = hl
  end
end
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
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
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
          item.kind_hl_group = hl
          tailwind(entry, item)
          return item
        end,
        fields = { "kind", "abbr", "menu" },
      },
      window = {
        completion = {
          scrollbar = false,
          winhighlight = "Normal:CmpDocumentation,CursorLine:PmenuSel,Search:None,FloatBorder:CmpDocumentationBorder",
          border = "rounded",
        },
        documentation = {
          border = "rounded",
          winhighlight = "Normal:CmpDocumentation,FloatBorder:CmpDocumentationBorder",
        },
      },
    })
  end,
}
