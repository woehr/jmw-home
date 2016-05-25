"http://fluffynukeit.com/setting-up-vim-for-haskell/
set nocompatible | filetype indent plugin on | syn on

fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'

  " Force your ~/.vim/after directory to be last in &rtp always:
  " let g:vim_addon_manager.rtp_list_hook = 'vam#ForceUsersAfterDirectoriesToBeLast'

  " most used options you may want to use:
  " let c.log_to_buf = 1
  let c.auto_install = 1
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif

  " This provides the VAMActivate command, you could be passing plugin names, too
  call vam#ActivateAddons([ 'github:tpope/vim-unimpaired'
        \                 , 'github:tpope/vim-sensible'
        \                 , 'github:altercation/vim-colors-solarized'
        \                 , 'github:bling/vim-airline'
        \                 , 'github:scrooloose/syntastic'
        \                 , 'github:raichoo/haskell-vim'
        \                 , 'github:pbrisbin/vim-syntax-shakespeare'
        \                 , 'github:wting/rust.vim'
        \                 , 'github:Shougo/vimproc.vim'
        \                 , 'github:Shougo/neocomplete.vim'
        \                 , 'github:eagletmt/neco-ghc'
        \                 , 'github:eagletmt/ghcmod-vim'
        \                 ], {})
endfun
call SetupVAM()

set encoding=utf8
set ffs=unix,dos,mac
set hlsearch
set incsearch
set confirm
set pastetoggle=<F11>
set number
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set mouse=a
set colorcolumn=80
set cmdheight=2
set ai
set si

let mapleader = ","
let g:mapleader = ","
set tm=2000

augroup haskell
  nmap <silent> <leader>ht :GhcModType<CR>
  nmap <silent> <leader>hh :GhcModTypeClear<CR>
  nmap <silent> <leader>hT :GhcModTypeInsert<CR>
  nmap <silent> <leader>hc :SyntasticCheck ghc_mod<CR>:lopen<CR>
  nmap <silent> <leader>hl :SyntasticCheck hlint<CR>:lopen<CR>

  setlocal omnifunc=necoghc#omnifunc

  autocmd!
  " Auto-checking on writing
  autocmd BufWritePost *.hs,*.lhs GhcModCheckAndLintAsync
augroup END

" SOLARIZED
syntax enable
set background=dark
colorscheme solarized

" SYNTASTIC
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_mode_map={'mode': 'active', 'passive_filetypes': ['haskell']}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"let g:syntastic_debug = 3

" Neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h>  neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>   neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" Necoghc
let g:necoghc_enable_detailed_browse = 1

" vim2hs
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1

let g:haskell_indent_if = 3
let g:haskell_indent_case = 5
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1

