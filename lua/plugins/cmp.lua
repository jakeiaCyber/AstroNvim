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
local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end
local function is_visible(cmp) return cmp.core.view:visible() or vim.fn.pumvisible() == 1 end
local function mapping()
  local cmp = require "cmp"
  return {
    ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
    ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
    ["<C-P>"] = cmp.mapping(function()
      if is_visible(cmp) then
        cmp.select_prev_item()
      else
        cmp.complete()
      end
    end),
    ["<C-N>"] = cmp.mapping(function()
      if is_visible(cmp) then
        cmp.select_next_item()
      else
        cmp.complete()
      end
    end),
    ["<C-K>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<C-J>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    ["<C-U>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-D>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-Y>"] = cmp.config.disable,
    ["<C-E>"] = cmp.mapping(cmp.mapping.abort(), { "i", "c" }),
    ["<CR>"] = cmp.mapping(cmp.mapping.confirm { select = false }, { "i", "c" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if is_visible(cmp) then
        cmp.select_next_item()
      elseif vim.api.nvim_get_mode().mode ~= "c" and vim.snippet and vim.snippet.active { direction = 1 } then
        vim.schedule(function() vim.snippet.jump(1) end)
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if is_visible(cmp) then
        cmp.select_prev_item()
      elseif vim.api.nvim_get_mode().mode ~= "c" and vim.snippet and vim.snippet.active { direction = -1 } then
        vim.schedule(function() vim.snippet.jump(-1) end)
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
