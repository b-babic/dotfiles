local opts = {
    events = { -- loading buffer after nvim-lint: event="BufReadPost"
    "BufReadPost", -- some linters require saving file
    "BufWritePost", "InsertLeave" -- more aggresive (e.g., undo)
    },
    linters_by_ft = {
        github_action = { -- Static checker for GitHub Actions workflow files
        "actionlint",
        "yamllint"
        },
        vue = {'stylelint'},
        sugarss = {'stylelint'},
        wxss = {'stylelint'},
        less = {'stylelint'},
        scss = {'stylelint'},
        css = {'stylelint'},
        ruby = {'rubocop'},
        eruby = {'erb_lint'},
        lua = {'luacheck'},
        go = {'golangcilint'}
    },
    root_patterns_by_ft = {
        lua = {
            selene = {"selene.toml", ".git"},
            luacheck = {".luarc.json", ".git"}
        },
        github_action = {
            yamllint = {".yamllint.yaml", ".yamllint.yml", ".yamllint"}
        },
        ruby = {
            standardrb = {".standardrb.yml", ".rubocop.yml", ".git"}
        },
        eruby = {
            erb_lint = {".erb-lint.yml", ".git"}
        }
    }
}

local lint = require("lint")
local api = vim.api
local fs = vim.fs
lint.linters_by_ft = opts.linters_by_ft

---Set cwd for linters specified by opts.root_patterns_by_ft[filetype]
---@param linter_root_patterns table<string, string[]>? a mapping of linter to patterns
local function set_linters_cwd(linter_root_patterns)
    for linter, root_patterns in pairs(linter_root_patterns or {}) do
        local root_path = root_patterns and fs.root(0, root_patterns)
        if root_path then
            lint.linters[linter].cwd = root_path
            -- you can set cwd to buffer's parent dir if no root is found
            -- else
            --   lint.linters[linter].cwd = fs.dirname(api.nvim_buf_get_name(0))
        end
    end
end

local lint_augroup = api.nvim_create_augroup("nvim-lint", {
    clear = true
})
api.nvim_create_autocmd(opts.events, {
    group = lint_augroup,
    callback = function()
        if filetype == "yaml" and string.find(path, ".github/workflows/") then
            set_linters_cwd(opts.root_patterns_by_ft.github_action)
            lint.try_lint(opts.linters_by_ft.github_action)
            return
        end
        set_linters_cwd(opts.root_patterns_by_ft[filetype])
        lint.try_lint()
    end
})

vim.keymap.set("n", "<leader>ll", function()
    lint.try_lint()
end, {
    desc = "Trigger linting for current file"
})

-- Define default linters
-- lint.linters_by_ft = {
--     vue = {'stylelint'},
--     sugarss = {'stylelint'},
--     wxss = {'stylelint'},
--     less = {'stylelint'},
--     scss = {'stylelint'},
--     css = {'stylelint'},
--     ruby = {'standardrb'},
--     eruby = {'erb_lint'},
--     lua = {'luacheck'}
-- }

-- Helpers
-- local function is_gem_installed(gem_name)
--     local handle = io.popen('gem list -i ' .. gem_name)
--     local result = handle:read("*a")
--     handle:close()
--     return result:match("true")
-- end

-- local function file_exists(name)
--     local f = io.open(name, "r")
--     if f ~= nil then
--         io.close(f)
--         return true
--     else
--         return false
--     end
-- end

-- Conditional linters

-- Only enable standardrb if the project has a Gemfile and standardrb is installed
-- if not is_gem_installed('standardrb') then
--     lint.linters_by_ft.ruby = nil
-- end

-- -- Only enable erb_lint if .erb-lint.yml config file is present
-- if not file_exists('.erb-lint.yml') then
--     lint.linters_by_ft.eruby = nil
-- end

-- Keymaps
-- vim.keymap.set("n", "<leader>ll", function()
--     lint.try_lint()
-- end, {
--     desc = "Trigger linting for current file"
-- })

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
