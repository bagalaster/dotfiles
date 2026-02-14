return {
  'pwntester/octo.nvim',
  commit = 'f60d563',
  dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
  },
  config = function()
      require("octo").setup({
          default_merge_method = "squash",
          default_delete_branch = true,
          default_to_projects_v2 = false,
          enable_builtin = true,
      })
  end,
}
