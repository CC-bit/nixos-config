-- 关闭行尾的诊断信息显示，只保留左侧图标
-- 方法 A (自动): 把光标移到有下划线的代码上，等 1 秒，会自动弹出一个悬浮窗显示完整错误。
-- 方法 B (手动): 按 <leader>cd (即空格+c+d) 查看当前行的错误。
-- 方法 C (列表): 按 <leader>xx 打开底部的 Trouble 面板，查看所有错误列表。

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false, -- 代码诊断关闭行尾虚拟文本
        underline = true, -- 保留下划线
        signs = true, -- 保留左侧图标
      },
    },
  },
}
