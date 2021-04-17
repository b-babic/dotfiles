" Enable auto installation of LSP servers
let g:lsp_settings = {
\  'pyls-all': {'workspace_config': {'pyls': {'plugins': {
\    'pycodestyle': {'enabled': v:true},
\    'pylint': {'enabled': v:true},
\    'flake8': {'enabled': v:true},
\  }}}},
\  'typescript-language-server': {'allowlist': ['typescript', 'typescript.tsx', 'javascript', 'javascript.jsx']},
\  'gopls': {'allowlist': ['go']},
\  'html-languageserver': {'allowlist': ['html']},
\  'css-languageserver': {'allowlist': ['css', 'less', 'sass']},
\  'bash-language-server': {'allowlist': ['sh', 'bash']},
\  'dockerfile-language-server': {'allowlist': ['dockerfile']},
\  'vim-language-server': {'allowlist': ['vim']},
\  'yaml-language-server': {'allowlist': ['yaml', 'yaml.ansible']},
\  'json-languageserver': {'allowlist': ['json', 'jsonc']},
\}

" Automatically install servers on first open of allowed file types
let g:lsp_settings_filetype_python = ['pyls-all']
let g:lsp_settings_filetype_typescript = ['typescript-language-server']
let g:lsp_settings_filetype_javascript = ['typescript-language-server']
let g:lsp_settings_filetype_go = ['gopls']
let g:lsp_settings_filetype_html = ['html-languageserver']
let g:lsp_settings_filetype_css = ['css-languageserver']
let g:lsp_settings_filetype_sh = ['bash-language-server']
let g:lsp_settings_filetype_dockerfile = ['dockerfile-language-server']
let g:lsp_settings_filetype_vim = ['vim-language-server']
let g:lsp_settings_filetype_yaml = ['yaml-language-server']
let g:lsp_settings_filetype_json = ['json-languageserver']

" Basic LSP settings
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_document_highlight_enabled = 1
let g:lsp_completion_documentation_enabled = 1
let g:lsp_completion_documentation_delay = 50

" Signs for diagnostics
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '⚠'}
let g:lsp_signs_information = {'text': 'ℹ'}
let g:lsp_signs_hint = {'text': '➤'}
let g:lsp_document_code_action_signs_enabled = 1
let g:lsp_document_code_action_signs_hint = {'text': '💡'}

let g:lsp_completion_kinds = {
    \ 'Text': ' ',
    \ 'Method': ' ',
    \ 'Function': ' ',
    \ 'Constructor': ' ',
    \ 'Field': 'ﴲ ',
    \ 'Variable': ' ',
    \ 'Class': ' ',
    \ 'Interface': 'ﰮ ',
    \ 'Module': ' ',
    \ 'Property': '襁',
    \ 'Unit': ' ',
    \ 'Value': ' ',
    \ 'Enum': ' ',
    \ 'Keyword': ' ',
    \ 'Snippet': '﬌ ',
    \ 'Color': ' ',
    \ 'File': ' ',
    \ 'Reference': ' ',
    \ 'Folder': ' ',
    \ 'EnumMember': ' ',
    \ 'Constant': ' ',
    \ 'Struct': 'פּ ',
    \ 'Event': ' ',
    \ 'Operator': ' ',
    \ 'TypeParameter': ' ',
    \ }

" Completion settings
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_popup_delay = 200
let g:asyncomplete_min_chars = 1

" Additional completion triggers
let g:asyncomplete_triggers = {
    \ '*': ['.', '>', ':', '<', '"', '/', '\'],
    \ 'vim': ['re![a-zA-Z0-9_.]'],
    \ 'php': ['re![a-zA-Z0-9_\->\|::]'],
    \ 'javascript,typescript': ['re![a-zA-Z0-9_\->\|::]'],
    \ }

" Auto pairs for brackets and quotes
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap ' ''<Left>
inoremap " ""<Left>
inoremap ` ``<Left>

" Smart brackets and quotes (won't add closing if it already exists)
function! s:smart_close(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction
inoremap <expr> ) <SID>smart_close(')')
inoremap <expr> ] <SID>smart_close(']')
inoremap <expr> } <SID>smart_close('}')
inoremap <expr> ' <SID>smart_close("'")
inoremap <expr> " <SID>smart_close('"')
inoremap <expr> ` <SID>smart_close('`')


" Configure completion menu
set completeopt=menuone,noinsert,noselect,preview

" Popup menu colors
" highlight Pmenu ctermbg=236 guibg=#2d2d2d
" highlight PmenuSel ctermbg=240 guibg=#3d3d3d
" highlight PmenuSbar ctermbg=238 guibg=#333333
" highlight PmenuThumb ctermbg=242 guibg=#4d4d4d

" Key mappings
function! s:lsp_keymaps() abort
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer> <leader>ca <plug>(lsp-code-action)
    nmap <buffer> <leader>f <plug>(lsp-document-format)
endfunction

" Completion navigation
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
" Preview window scrolling with arrow keys
inoremap <expr> <Down> pumvisible() ? "\<C-f>" : "\<Down>"
inoremap <expr> <Up> pumvisible() ? "\<C-b>" : "\<Up>"

" And if you want these in normal mode too:
nnoremap <expr> <Down> &previewwindow ? "\<C-f>" : "\<Down>"
nnoremap <expr> <Up> &previewwindow ? "\<C-b>" : "\<Up>"

" Apply LSP keymaps when LSP attaches
augroup lsp_install
    au!
    au User lsp_buffer_enabled call s:lsp_keymaps()
augroup END

" Auto-close preview window
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Format on save (optional)
augroup format_on_save
    au!
    autocmd BufWritePre *.py,*.js,*.jsx,*.ts,*.tsx,*.go,*.html,*.css,*.json,*.lua,*.yaml,*.toml,*.md
        \ call execute('LspDocumentFormatSync')
augroup END
