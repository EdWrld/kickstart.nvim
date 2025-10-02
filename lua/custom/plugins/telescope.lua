return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'

    -- lua/util/telescope_cycle.lua
    local findCycler = {}

    -- Define your sequence: picker name, optional opts, and a hotkey to jump to it
    local sequence = {
      {
        name = 'current_buffer_fuzzy_find',
        opts = require('telescope.themes').get_dropdown { winblend = 10, previewer = false },
        hotkey = '<C-f>',
      },
      {
        name = 'find_files',
        opts = {},
        hotkey = '<M-f>',
      },
      { name = 'live_grep', opts = {}, hotkey = '<C-g>' },
      { name = 'lsp_document_symbols', opts = {}, hotkey = '<C-s>' },
      { name = 'lsp_dynamic_workspace_symbols', opts = {}, hotkey = '<C-w>' },
    }

    -- Build a reverse lookup: hotkey -> index
    local key_to_index = {}
    for i, e in ipairs(sequence) do
      if e.hotkey then
        key_to_index[e.hotkey] = i
      end
    end

    local idx = 1

    local function run(i)
      local actions = require 'telescope.actions'

      local entry = sequence[i]

      -- Merge user opts with our attach_mappings
      local opts = vim.tbl_deep_extend('force', entry.opts or {}, {
        attach_mappings = function(prompt_bufnr, map)
          -- Cycle to next picker with <Tab>
          local function cycle()
            actions.close(prompt_bufnr)
            vim.schedule(function()
              idx = (i % #sequence) + 1
              run(idx)
            end)
          end

          -- Jump directly to a specific picker by hotkey
          local function jump_to(hotkey)
            local target = key_to_index[hotkey]
            if not target then
              return
            end
            actions.close(prompt_bufnr)
            vim.schedule(function()
              idx = target
              run(idx)
            end)
          end

          -- map Alt l in both modes to cycle
          map('i', '<M-l>', cycle)
          map('n', '<M-l>', cycle)

          -- map all hotkeys defined in the sequence to jumps
          for hotkey, _ in pairs(key_to_index) do
            map('i', hotkey, function()
              jump_to(hotkey)
            end)
            map('n', hotkey, function()
              jump_to(hotkey)
            end)
          end

          return true
        end,
      })

      builtin[entry.name](opts)
    end

    function findCycler.open()
      run(idx)
    end

    -- somewhere in your config
    vim.keymap.set('n', '<leader><leader>', function()
      findCycler.open()
    end, { desc = 'Search (cycle pickers)' })

    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = '[S]earch Document Symbols' })
    vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader-fS>', builtin.lsp_dynamic_workspace_symbols, { desc = '[S]earch Project Document Symbols' })
    -- vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })

    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    -- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- Change directory to the directory of the current buffer
    vim.keymap.set('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', { silent = true })

    -- Slightly advanced example of overriding default behavior and theme
    -- vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    -- builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    -- winblend = 10,
    -- previewer = false,
    -- })
    -- end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
