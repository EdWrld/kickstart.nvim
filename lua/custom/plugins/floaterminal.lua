return {
  'numToStr/FTerm.nvim',
  config = function()
    local fterm = require 'FTerm'

    fterm.setup {
      border = 'rounded', -- or 'single', 'double'
      blend = 0,
      dimensions = {
        height = 0.9,
        width = 0.9,
        x = 0.5,
        y = 0.5,
      },
    }

    local copilot_term = fterm:new {
      cmd = "nvim -c 'CopilotChatToggle'",
    }

    local dbui_term = fterm:new {
      cmd = "nvim -c 'DBUI'",
    }

    local neogit_term = fterm:new {
      cmd = "nvim -c 'Neogit'",
    }

    vim.keymap.set({ 'n', 't' }, '<leader>tt', fterm.toggle, { desc = 'Toggle FTerm' })

    -- Keymaps to toggle each terminal
    vim.keymap.set({ 'n', 't' }, '<leader>tc', function()
      copilot_term:toggle()
    end, { desc = 'Toggle Copilot Terminal' })

    vim.keymap.set({ 'n', 't' }, '<leader>td', function()
      dbui_term:toggle()
    end, { desc = 'Toggle Dadbod DBUI Terminal' })

    vim.keymap.set({ 'n', 't' }, '<leader>tg', function()
      neogit_term:toggle()
    end, { desc = 'Toggle Neogit Terminal' })
  end,
}
