{ pkgs }:
let
  inherit (pkgs) fetchgit stdenv writeText;
  inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;

  extraPlugins = import ./my-vim-plugins.nix {
    inherit buildVimPluginFrom2Nix;
    inherit fetchgit;
  };

  my-config = {
    customRC = ''
      set nocompatible
      set number
      set tabstop=2
      set softtabstop=2
      set shiftwidth=2
      set expandtab
      set colorcolumn=80
      set cmdheight=6
      set mouse=a
      set autoindent
      set smartindent
      set linebreak
      set ignorecase
      set smartcase
      set title
      set updatetime=1000

      " Nice tab completion behaviour
      set wildmode=longest,list,full
      set wildmenu

      " nvim will interact with the system clipboard
      set clipboard+=unnamedplus

      filetype on

      let mapleader = ","
      let maplocalleader = ","

      augroup latexSettings
        au!
        au FileType tex set tabstop=2
        au FileType tex set softtabstop=2
        au FileType tex set shiftwidth=2
        au FileType tex set expandtab
        au FileType tex set colorcolumn=
        au FileType tex set wrap wrapmargin=0 textwidth=0 formatoptions-=t
        au FileType tex set breakindent showbreak=> breakindentopt=shift:4,sbr
        au FileType tex setlocal spell spelllang=en_gb
      augroup END

      " To see whether the leader has timed out
      set showcmd

      " Wrap beginning/end of lines
      set whichwrap+=<,>,h,l,[,]

      " Remap ESC to exit terminal mode
      tnoremap <Esc> <C-\><C-n>

      " Completion related settings
      " ctrl-d and ctrl-u for page up/down in the popup menu
      inoremap <expr> <C-d> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
      inoremap <expr> <C-u> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

      set completeopt=menuone,noinsert,noselect

      " Alt-arrow to switch windows
      nnoremap <silent> <A-Right> <C-w>l
      nnoremap <silent> <A-Left> <C-w>h
      nnoremap <silent> <A-Up> <C-w>k
      nnoremap <silent> <A-Down> <C-w>j

      " Shift-arrow to move windows
      nnoremap <silent> <S-Right> <C-w>L
      nnoremap <silent> <S-Left> <C-w>H
      nnoremap <silent> <S-Up> <C-w>K
      nnoremap <silent> <S-Down> <C-w>J

      " Arrow and home/end through wrapped lines
      "map <silent> <Up> gk
      "imap <silent> <Up> <C-o>gk
      "map <silent> <Down> gj
      "imap <silent> <Down> <C-o>gj
      "map <silent> <Home> g<Home>
      "imap <silent> <Home> <C-o>g<Home>
      "map <silent> <End> g<End>
      "imap <silent> <End> <C-o>g<End>

      """"""""""""""" themes """""""""""""""
      syntax enable

      "set background=light
      set background=dark

      colorscheme angr

      """"""""""""""" airline """""""""""""""
      let g:airline_theme='angr'

      """"""""""""""" deoplete """""""""""""""
      let g:deoplete#enable_at_startup = 1

      """"""""""""""" Neoformat """""""""""""""
      "let g:neoformat_only_msg_on_error = 1

      """"""""""""""" Haskell stuff """""""""""""""
      let g:haskell_classic_highlighting = 1
      let g:haskell_enable_quantification = 1
      let g:haskell_enable_recursivedo = 1
      let g:haskell_enable_arrowsyntax = 1
      let g:haskell_enable_pattern_synonyms = 1
      let g:haskell_enable_typeroles = 1
      let g:haskell_enable_static_pointers = 1
      let g:haskell_backpack = 1
      let g:haskell_indent_disable = 1

      " For ghc-mod completion with necoghc
      " Disable haskell-vim omnifunc
      let g:haskellmode_completion_ghc = 0
      au FileType haskell setlocal omnifunc=necoghc#omnifunc
      let g:necoghc_enable_detailed_browse = 1
      let g:necoghc_debug = 1
      let g:ghcmod_ghc_options = [ '-ilib', '-isrc', '-itest' ]

      augroup ghciMaps
        au!
        au FileType haskell nnoremap <silent> <leader>go :Ghcid<CR><C-w>H
        au FileType haskell nnoremap <silent> <leader>gk :GhcidKill<CR>
      augroup END

      """"""""""""""" ALE """""""""""""""
      let g:ale_linters = {
      \ 'haskell': ['hlint', 'ghc'],
      \ 'javascript': ['jshint'],
      \ 'sh': ['shellcheck'],
      \ 'tex': ['chktex'],
      \}
      let g:ale_fixers = {
      \ 'haskell': ['brittany'],
      \ 'javascript': ['prettier-eslint'],
      \ 'sh': ['shfmt'],
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \}
      let g:ale_fix_on_save = 1
      let g:ale_sign_column_always = 1
      let g:ale_haskell_ghc_options = '-ilib -isrc -itest -v0 -outputdir .ghc.d -fobject-code'
      let g:airline#extensions#ale#enabled = 1

      let g:ale_set_highlights = 0
      highlight clear ALEErrorSign
      highlight clear ALEWarningSign

      nmap <silent> <C-k> <Plug>(ale_previous_wrap)
      nmap <silent> <C-j> <Plug>(ale_next_wrap)

      """"""""""""""" tex """""""""""""""
      let g:tex_flavor = 'latex'

      """"""""""""""" vimtex """""""""""""""
      let g:vimtex_enabled = 1
      let g:vimtex_compiler_progname = 'nvr'
      let g:vimtex_view_use_temp_files = 1
      let g:vimtex_view_forward_search_on_start = 1
      let g:vimtex_view_method = 'mupdf'

      if !exists('g:deoplete#omni#input_patterns')
        let g:deoplete#omni#input_patterns = {}
      endif
      let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
    '';

    vam.knownPlugins = pkgs.vimPlugins // extraPlugins;
    vam.pluginDictionaries = [
      { names =
        [ "ale"
          "alex-vim"
          "angr-vim"
          "deoplete-nvim"
          "ghcid"
          "happy-vim"
          "haskell-vim"
          "lbnf-vim"
          "neco-ghc"
          "vimtex"
          "vim-airline"
          "vim-airline-themes"
          "vim-nix"
        ];
      }
    ];
  };
  my-nvim = pkgs.neovim.override {
    vimAlias = true;
    configure = my-config;
  };
in my-nvim.overrideAttrs (old: {
})
