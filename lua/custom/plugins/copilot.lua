return {
  {
    {
      'zbirenbaum/copilot.lua',
      event = 'InsertEnter',
      cmd = 'Copilot',
      opts = {
        panel = { enabled = true }, -- no side panel; keep it simple
        suggestion = {
          enabled = true, -- inline ghost text
          auto_trigger = false, -- show suggestions as you type
          hiding_during_composition = true, -- must have this on
          trigger_on_accept = true,
          debounce = 75,
          keymap = {
            accept = '<C-\\>', -- accept entire suggestion
            accept_line = false, -- set your own if you want
            accept_word = false, -- set your own if you want
            next = '<M-]>', -- cycle next suggestion
            prev = '<M-[>', -- cycle previous suggestion
            dismiss = '<C-n>', -- hide the ghost text
          },
        },
        filetypes = {
          markdown = true,
          help = false,
          gitcommit = true,
          lua = true,
          typescript = true,
          sql = true,
          -- add any filetypes you want to enable/disable
        },
      },
      config = function(_, opts)
        require('copilot').setup(opts)
        vim.api.nvim_set_hl(0, 'CopilotSuggestion', { fg = '#50fa7b', italic = true })
      end,
    },
  },
}
