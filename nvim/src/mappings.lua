  -- Helper function
  local keymap = function(mode, keys, cmd, opts)
    opts = opts or {}
    if opts.silent == nil then opts.silent = true end
    vim.keymap.set(mode, keys, cmd, opts)
  end

  -- NOTE: Most mappings come from 'mini.basics'

  -- Shorter version of the most frequent way of going outside of terminal window
  keymap('t', [[<C-h>]], [[<C-\><C-N><C-w>h]])

  -- Move inside completion list with <TAB>
  keymap('i', [[<Tab>]], [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
  keymap('i', [[<S-Tab>]], [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })

  -- Delete selection in Select mode (helpful when editing snippet placeholders)
  keymap('s', [[<BS>]], [[<BS>i]])

  -- Better command history navigation
  keymap('c', '<C-p>', '<Up>', { silent = false })
  keymap('c', '<C-n>', '<Down>', { silent = false })

  -- Stop highlighting of search results. NOTE: this can be done with default
  -- `<C-l>` but this solution deliberately uses `:` instead of `<Cmd>` to go
  -- into Command mode and back which updates 'mini.map'.
  keymap('n', [[\h]], ':let v:hlsearch = 1 - v:hlsearch<CR>', { desc = 'Toggle hlsearch' })

  -- Paste before/after linewise
  keymap({ 'n', 'x' }, '[p', '<Cmd>exe "put! " . v:register<CR>', { desc = 'Paste Above' })
  keymap({ 'n', 'x' }, ']p', '<Cmd>exe "put "  . v:register<CR>', { desc = 'Paste Below' })
