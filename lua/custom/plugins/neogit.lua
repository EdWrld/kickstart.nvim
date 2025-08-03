return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
      -- Only one of these is needed.
      'ibhagwan/fzf-lua', -- optional
      'echasnovski/mini.pick', -- optional
      'folke/snacks.nvim', -- optional
    },
  },
  {
    'ldelossa/gh.nvim',
    dependencies = { 'ldelossa/litee.nvim' },
    config = function()
      require('litee.lib').setup()
      require('litee.gh').setup()
    end,
  },
  vim.keymap.set('n', '<leader>gp', ':GHSearchPRs <CR> is:open <CR>', { desc = 'GitHub Open PR list' }),
}
