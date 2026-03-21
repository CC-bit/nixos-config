return {
  "mfussenegger/nvim-lint",
  opts = {
    -- 告诉 nvim-lint：
    -- 遇到 C 语言文件 (c) -> 用 cppcheck
    -- 遇到 C++ 文件 (cpp) -> 用 cppcheck
    linters_by_ft = {
      c = { "cppcheck" },
      cpp = { "cppcheck" },
    },
  },
}
