return {
  {
    'tpope/vim-fugitive',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- Optional: open files/commits on GitHub with :GBrowse
      {
        'tpope/vim-rhubarb',
        cond = function()
          return vim.fn.executable 'git' == 1
        end,
      },
    },
    config = function()
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
      end

      -- Core
      map('n', '<leader>gs', ':Git<CR>', 'Git status')
      map('n', '<leader>gc', ':Git commit<CR>', 'Git commit')
      map('n', '<leader>gp', ':Git push<CR>', 'Git push')
      map('n', '<leader>gP', ':Git pull --rebase<CR>', 'Git pull --rebase')

      -- Blame & diff
      map('n', '<leader>gb', ':Git blame<CR>', 'Git blame (inline)')
      map('n', '<leader>gd', ':Gvdiffsplit<CR>', 'Git vertical diff')
      map('n', '<leader>gD', ':Gdiffsplit!<CR>', 'Git 3-way diff (resolve)')

      -- File-level ops
      map('n', '<leader>gr', ':Gread<CR>', 'Revert file to index/HEAD')
      map('n', '<leader>gw', ':Gwrite<CR>', 'Stage current file')
      map('n', '<leader>gl', ':Git log --oneline --decorate --graph<CR>', 'Git log')

      -- Open on remote (needs vim-rhubarb and a GitHub remote)
      map('n', '<leader>go', ':GBrowse<CR>', 'Open on GitHub')
      map('v', '<leader>go', ':GBrowse<CR>', 'Open range on GitHub')
    end,
  },
}
