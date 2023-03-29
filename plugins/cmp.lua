return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",
    "jc-doyle/cmp-pandoc-references",
    "kdheepak/cmp-latex-symbols",
  },
  opts = function(_, opts)
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    local lspkind = require "lspkind"



    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
    end

    local function next_item()
      if cmp.visible() then
        cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
      else
        cmp.complete()
      end
    end

    return require("astronvim.utils").extend_tbl(opts, {
      window = {
        completion = {
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:Visual,Search:None",
          border = "none",
          col_offset = -1,
          side_padding = 0,
        },
      },
      sources = cmp.config.sources {
        { name = "copilot",           priority = 1100 },
        { name = "nvim_lsp",          priority = 1000 },
        { name = "luasnip",           priority = 750 },
        { name = "pandoc_references", priority = 725 },
        { name = "latex_symbols",     priority = 700 },
        { name = "emoji",             priority = 700 },
        { name = "calc",              priority = 650 },
        { name = "path",              priority = 500 },
        { name = "buffer",            priority = 250 },
      },
      mapping = {
        ["<C-n>"] = next_item,
        ["<C-j>"] = next_item,
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol",
          max_width = 50,
          symbol_map = { Copilot = "" }
        })
      }
    })
  end,
}
