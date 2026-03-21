return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      c = { "clang-format" },
      cpp = { "clang-format" },
      python = { "isort", "black" },
      lua = { "stylua" },
    },

    -- 在这里配置各个工具的默认参数
    formatters = {
      -- 1. C/C++ (clang-format) 的默认规则
      clang_format = {
        -- 这里的 style 参数就是你的“默认配置”
        -- BasedOnStyle: Google 是基础风格
        -- IndentWidth: 4 强制改为 4 格缩进
        prepend_args = {
          "--style={BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 100}",
        },
      },

      -- 2. Python (black) 的默认规则
      black = {
        -- 比如强制每行最大长度为 100 字符 (默认是 88)
        prepend_args = { "--line-length", "100" },
      },

      -- 3. Lua (stylua) 的默认规则
      stylua = {
        -- 强制使用 2 个空格缩进，不用 Tab
        prepend_args = {
          "--indent-type",
          "Spaces",
          "--indent-width",
          "2",
        },
      },
    },
  },
}
