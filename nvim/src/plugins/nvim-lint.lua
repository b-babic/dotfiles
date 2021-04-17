local lint = require('lint');

lint.linters_by_ft = {
    vue = { 'stylelint' },
    sugarss = { 'stylelint' },
    wxss = { 'stylelint' },
    less = { 'stylelint' },
    scss = { 'stylelint' },
    css = { 'stylelint' },
    ruby = { 'standardrb' },
    eruby = { 'erb_lint' },
    lua = { 'luacheck' },
}

-- Only enable typos for certain filetypes
-- for ft, _ in pairs(lint.linters_by_ft) do
--     table.insert(lint.linters_by_ft[ft], 'cspell')
-- end

-- vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
--     group = vim.api.nvim_create_augroup('lint', { clear = true }),
--     callback = function()
--         lint.try_lint()
--         lint.try_lint("typos")
--     end
-- });

vim.keymap.set("n", "<leader>ll", function()
    lint.try_lint()
  end, { desc = "Trigger linting for current file" })
