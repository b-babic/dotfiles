require('conform').setup({
    -- Map of filetype to formatters
    formatters_by_ft = {
      javascript = { 'biome', 'eslint_d', 'eslint', stop_after_first = true },
      javascriptreact = { 'biome', 'eslint_d', 'eslint', stop_after_first = true },
      typescript = { 'biome', 'eslint_d', 'eslint', stop_after_first = true },
      typescriptreact = { 'biome', 'eslint_d', 'eslint', stop_after_first = true },
      json = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
      jsonc = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
      lua = { 'stylua' },
      python = { 'black' },
      ruby = { 'standardrb' },
      eruby = { 'htmlbeautifier' },
      sh = { 'shfmt' },
      ["_"] = { "trim_whitespace" },
    },
    formatters = {
        trim_whitespace = {
            exe = "sed",
            args = { "-i", "", "-e", "s/[[:space:]]*$//" },
            stdin = true,
        },
    },
    -- Rest of the config
    notify_on_error = true,
    notify_no_formatters = true,
  })
