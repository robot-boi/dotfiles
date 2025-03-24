return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<F2>",
          accept_word = false,
          accept_line = false,
        },
      },
    },
  },
  { "zbirenbaum/copilot-cmp", enabled = false },
}
