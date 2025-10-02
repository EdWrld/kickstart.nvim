return {
  'numToStr/Comment.nvim',
  keys = {
    -- Normal mode
    -- { 'gcc', mode = 'n', desc = 'Comment toggle current line' },
    -- { 'gc', mode = { 'n', 'o' }, desc = 'Comment toggle linewise' },
    -- { 'gbc', mode = 'n', desc = 'Comment toggle current block' },
    -- { 'gb', mode = { 'n', 'o' }, desc = 'Comment toggle blockwise' },
    --
    -- Visual mode
    -- { 'gc', mode = 'x', desc = 'Comment toggle linewise (visual)' },
    -- { 'gb', mode = 'x', desc = 'Comment toggle blockwise (visual)' },
    -- Normal mode: toggle current line
    {
      '<C-_>', -- this is what Ctrl-/ is detected as
      function()
        require('Comment.api').toggle.linewise.current()
      end,
      mode = 'n',
      desc = 'Toggle comment (current line)',
    },
    -- Visual mode: toggle selection
    {
      '<C-_>',
      function()
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false) -- exit visual to preserve selection type
        require('Comment.api').toggle.linewise(vim.fn.visualmode())
      end,
      mode = 'x',
      desc = 'Toggle comment (selection)',
    },
  },
}
