return {
  'folke/persistence.nvim',
  event = 'BufReadPre', -- load early so it can capture your session
  opts = {
    -- default save_dir: stdpath("state") .. "/sessions"
    -- you can change it with: dir = vim.fn.stdpath("data") .. "/sessions",
  },
  keys = {
    {
      '<leader>qs',
      function()
        require('persistence').load()
      end,
      desc = 'Restore last session',
    },
    {
      '<leader>ql',
      function()
        require('persistence').load { last = true }
      end,
      desc = 'Restore last session',
    },
    {
      '<leader>qd',
      function()
        require('persistence').stop()
      end,
      desc = 'Stop session saving',
    },
  },
}
