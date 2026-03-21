-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- 默认缩进为 4 个空格
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- 把 tab 转换为空格

-- 如果你想针对特定文件类型设置（比如 Lua 还是保持 2 格）
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2
  end,
})

-- 设置在第 100 列显示一条竖线
vim.opt.colorcolumn = "100"
