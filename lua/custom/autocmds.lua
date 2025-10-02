-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Open Neovim Terminal',
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- Save on leaving insert mode or switching buffers/windows
--Pros:
-- You’ll almost never lose work — it’s auto-saved extremely often.
-- Works across all buffers, not just the active one.

-- Cons:
-- If you make a change accidentally, it’s instantly written to disk — undo history in Vim is fine, but there’s no "unsaved buffer" safety net.
-- Can cause a lot of disk writes if you’re editing many files quickly (probably negligible unless you’re on a network drive or very large files).

-- vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
-- pattern = '*',
-- command = 'silent! wall', -- save All buffers without messages
-- })
