local telescope = require("telescope")

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    layout_config = { width = 0.95, height = 0.90 },
  },
})

telescope.load_extension("fzf")
