vim.api.nvim_set_keymap("n", "s", "<Plug>Lightspeed_omni_s", {noremap = true})
vim.api.nvim_set_keymap("n", "gs", "<Plug>Lightspeed_omni_gs", {noremap = true})

require("lightspeed").setup {
  ignore_case = true,
}
