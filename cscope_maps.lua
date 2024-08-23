-- Nvim支持cscope配置文件
-- https://github.com/dhananjaylatkar/cscope_maps.nvim
return {
  {
    "dhananjaylatkar/cscope_maps.nvim",
    dependencies = {
      "folke/which-key.nvim", -- optional [for whichkey hints]
      "nvim-telescope/telescope.nvim", -- optional [for picker="telescope"]
      "ibhagwan/fzf-lua", -- optional [for picker="fzf-lua"]
      "echasnovski/mini.pick", -- optional [for picker="mini-pick"]
      "nvim-tree/nvim-web-devicons", -- optional [for devicons in telescope, fzf or mini.pick]
    },
    conifg = function()
      require("cscope_maps").setup()
    end,
    opts = {
      -- USE EMPTY FOR DEFAULT OPTIONS
      -- DEFAULTS ARE LISTED BELOW
      skip_input_prompt = false, -- "true" doesn't ask for input
      prefix = "<leader>C", -- prefix to trigger maps
      cscope = {
        picker = "telescope", -- "quickfix", "telescope", "fzf-lua" or "mini-pick"
      },
    },
  },
}
