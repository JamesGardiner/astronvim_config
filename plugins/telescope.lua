return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  opts = function(_, opts)
    local trouble = require("trouble")
    local actions = require("telescope.actions")
    return require("astronvim.utils").extend_tbl(opts, {
      defaults = {
        mappings = {
          i = {
            -- horizontal split
            ["<C-x>"] = false,
            ["<C-s>"] = actions.select_vertical,
            ["<CR>"] = actions.select_default + actions.center,
            ["<C-p>"] = actions.select_default + actions.center,
            -- next | prev
            ["<C-n>"] = actions.move_selection_next,
            ["<C-e>"] = actions.move_selection_previous,
            -- use esc for exit no normal mode
            ["<esc>"] = actions.close,
            ["<tab>"] = actions.toggle_selection,
            ["<C-q>"] = actions.send_to_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist,
            ["<C-t>"] = trouble.open_with_trouble,
            ["<C-h>"] = "which_key"
          },
          n = {
            -- horizontal split
            ["<C-x>"] = false,
            ["<C-s>"] = actions.select_vertical,
            ["<CR>"] = actions.select_default + actions.center,
            -- next | prev
            ["i"] = false,
            ["j"] = false,
            ["n"] = actions.move_selection_next,
            ["e"] = actions.move_selection_previous,
            -- use esc for exit no normal mode
            ["<esc>"] = actions.close,
            ["<C-t>"] = trouble.open_with_trouble,
            ["<C-h>"] = "which_key"
          },
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case"
        },
        prompt_prefix = ">",
        selection_carat = ">",
        entry_prefix = " ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            mirror = false,
          },
          vertical = {
            mirror = false,
          },
          -- width = 0.75,
          -- height = 1,
          -- preview_cutoff = 120,
          -- prompt_position = "bottom",
        },
        file_sorter = require "telescope.sorters".get_fuzzy_file,
        file_ignore_patterns = { "^%.git$", "node_modules", "venv", "poetry.lock" },
        generic_sorter = require "telescope.sorters".get_generic_fuzzy_sorter,
        path_display = {
          -- "shorten",
          "absolute"
        },
        winblend = 5,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" },
        file_previewer = require "telescope.previewers".vim_buffer_cat.new,
        grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
        qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case"
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- even more opts
          }
        }
      }
    })
  end,
  config = function(...)
    require("plugins.configs.telescope")(...)
    local telescope = require("telescope")
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
  end
}
