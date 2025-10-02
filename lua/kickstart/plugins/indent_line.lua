return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "│",       -- the vertical bar character
      },
      scope = {
        enabled = true,   -- turn on scope highlighting
        show_start = true,
        show_end = false,
        highlight = { "Function", "Label" }, -- pick highlight groups
      },
    },
    config = function(_, opts)
      local hooks = require("ibl.hooks")
      -- Make sure highlights are re-applied when colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IblScope", { fg = "#e5c07b", nocombine = true }) -- yellowish
      end)
      require("ibl").setup(opts)
    end,
  },
}
