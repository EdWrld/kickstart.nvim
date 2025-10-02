return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2', -- the new version (harpoon2) is recommended
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    -- REQUIRED for harpoon2
    harpoon:setup()

    -- Keymaps
    local opts = { noremap = true, silent = true }

    -- Add the current file
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, opts)

    -- Toggle quick menu
    vim.keymap.set('n', '<C-H>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, opts)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'harpoon',
      callback = function(ev)
        vim.keymap.set('n', 'd', function()
          local idx = vim.api.nvim_win_get_cursor(0)[1]
          harpoon:list():remove_at(idx)
          -- refresh the menu
          harpoon.ui:toggle_quick_menu(harpoon:list())
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { buffer = ev.buf, desc = 'Delete Harpoon Mark' })
      end,
    })

    -- Delete in quick menu
    vim.keymap.set('n', '<leader>hd', function()
      harpoon:list():remove()
    end, { desc = 'Remove current file from Harpoon' })

    -- Navigate between files (1–4 as example)
    vim.keymap.set('n', '<leader>1', function()
      harpoon:list():select(1)
    end, opts)
    vim.keymap.set('n', '<leader>2', function()
      harpoon:list():select(2)
    end, opts)
    vim.keymap.set('n', '<leader>3', function()
      harpoon:list():select(3)
    end, opts)
    vim.keymap.set('n', '<leader>4', function()
      harpoon:list():select(4)
    end, opts)

    vim.keymap.set('n', '<leader>5', function()
      harpoon:list():select(5)
    end, opts)

    vim.keymap.set('n', '<leader>6', function()
      harpoon:list():select(6)
    end, opts)

    vim.keymap.set('n', '<leader>7', function()
      harpoon:list():select(6)
    end, opts)
  end,
}
