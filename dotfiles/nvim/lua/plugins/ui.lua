return {
  -- 1. 配色方案配置
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      -- 在加载主题前开启透明背景选项
      vim.g.gruvbox_material_transparent_background = 1
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
  --{ "sainnhe/gruvbox-material" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },

  -- 2. 界面组件调整 (原 disabled.lua)
  -- 如果你确定不想用 lualine (状态栏)，就放在这里禁用
  { "nvim-lualine/lualine.nvim", enabled = false },
  -- 可选:
  -- { "rcarriga/nvim-notify", opts = { ... } } -- 通知弹窗
  -- { "akinsho/bufferline.nvim", opts = { ... } } -- 顶部标签栏
}
