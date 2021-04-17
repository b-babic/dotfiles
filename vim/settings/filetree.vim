nmap <Leader>d :Fern . -drawer -right -toggle<cr>
nmap <Leader>fo :Fern .<cr>

let g:fern#drawer_width = 35
let g:fern#renderer = "nerdfont"
let g:fern#default_hidden = 1
let g:fern#smart_cursor = "stick"
let g:fern#opener = "edit/vsplit"

" Enable preview window
let g:fern#preview#width = 80
let g:fern#preview#default = 1

" Set custom icons (requires vim-devicons or similar)
let g:fern#mark_symbol = '●'
let g:fern#collapsed_symbol = '▶'
let g:fern#expanded_symbol = '▼'

let g:fern#default_exclude = '^\%(\.git\|\.DS_Store\)$'

function! s:init_fern() abort
  nmap <buffer><silent> s <Plug>(fern-action-open:split)
  nmap <buffer><silent> v <Plug>(fern-action-open:vsplit)
  nmap <buffer><silent> yp <Plug>(fern-action-yank:path)
  nmap <buffer><silent> m <Plug>(fern-action-mark)
  nmap <buffer><silent> N <Plug>(fern-action-new-file)
  nmap <buffer><silent> K <Plug>(fern-action-new-dir)
  nmap <buffer><silent> M <Plug>(fern-action-move)
  nmap <buffer><silent> D <Plug>(fern-action-remove)
endfunction

augroup FernCustom
  autocmd!

  " Initialize custom mappings when Fern buffer is created
  autocmd FileType fern call s:init_fern()
augroup END
