return {
  'numToStr/Comment.nvim',
  keys = {
    -- Normal mode
    { 'gcc', mode = 'n', desc = 'Comment toggle current line' },
    { 'gc', mode = { 'n', 'o' }, desc = 'Comment toggle linewise' },
    { 'gbc', mode = 'n', desc = 'Comment toggle current block' },
    { 'gb', mode = { 'n', 'o' }, desc = 'Comment toggle blockwise' },

    -- Visual mode
    { 'gc', mode = 'x', desc = 'Comment toggle linewise (visual)' },
    { 'gb', mode = 'x', desc = 'Comment toggle blockwise (visual)' },

    -- <g>/ in normal mode
    {
      'g/',
      function()
        require('Comment.api').toggle.linewise.current()
      end,
      mode = 'n',
      desc = 'Toggle comment (current line)',
    },

    -- <leader>/ in visual mode
    -- {
    --   '<leader>/',
    --   "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    --   mode = 'x',
    --   desc = 'Toggle comment (visual selection)',
    -- },
  },
  config = function(_, opts)
    require('Comment').setup(opts)
  end,
}
