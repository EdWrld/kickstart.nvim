return {
  -- Main SQL query engine (Postgres supported)
  'tpope/vim-dadbod',

  -- Optional: Completion inside .sql files
  {
    'kristijanhusak/vim-dadbod-completion',
    ft = { 'sql', 'pgsql', 'postgres', 'plpgsql' },
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'sql', 'pgsql', 'postgres', 'plpgsql' },
        callback = function()
          require('cmp').setup.buffer {
            sources = {
              { name = 'vim-dadbod-completion' },
              { name = 'buffer' },
            },
          }
        end,
      })
    end,
  },

  -- UI for working with DBs
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = { 'tpope/vim-dadbod' },
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection' },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
