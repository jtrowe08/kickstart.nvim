-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  {
    name = 'local-terminals',
    dir = vim.fn.stdpath 'config',
    config = function()
      require('custom.plugins.toggle_term.toggle_term').setup()
      require('custom.plugins.copilot_term.copilot_term').setup()
    end,
  },
}
