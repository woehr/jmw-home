{ pkgs }:
let
  inherit (pkgs) fetchgit stdenv;
  inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;
  extraPlugins = {
    neco-look = buildVimPluginFrom2Nix {
      name = "neco-look";
      src = fetchgit {
        url = "git://github.com/ujihisa/neco-look";
        rev = "ff3de2731177694d0e85f1227b6cfd51c8e2bc8d";
        sha256 = "0zpny9sj7alzsbrjbph71b44zf575hij1ky8pwgba0ygp2p2fxd4";
      };
      dependencies = [];
    };
    neovim-ghci = buildVimPluginFrom2Nix {
      name = "neovim-ghci";
      src = fetchgit {
        url = "https://github.com/owickstrom/neovim-ghci";
        rev = "459c9584f6c816d6d60501ecb5bc746b69e30d0c";
        sha256 = "0rmxr82b28c1px2vd3qb8671v79dn5bwl890pid0njl1c7dlmmgf";
      };
      dependencies = [];
    };
    vim-airline-themes = buildVimPluginFrom2Nix {
      name = "vim-airline-themes";
      src = fetchgit {
        url = "https://github.com/vim-airline/vim-airline-themes";
        rev = "b0fca80555b8249f3c62271b7635542a7de22363";
        sha256 = "1ap7b7v1v3n4hpnj2w24w0dli2sliphvpyfhkdbhbq4c30znm1pk";
      };
      dependencies = [];
    };
    vim-angr = buildVimPluginFrom2Nix {
      name = "vim-angr";
      src = fetchgit {
        url = "https://github.com/zacanger/angr.vim";
        rev = "cf423e3785c1e9295de5fde4cf5a5d86d5006de3";
        sha256 = "16apxqcyapbgsrdaz21w7z7l9dvhlpz8762zmq6gn3qhnaz4yniz";
      };
      dependencies = [];
    };
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
      set cmdheight=2
      set mouse=a
      set autoindent
      set smartindent
      set linebreak
      set ignorecase
      set smartcase

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

      map <silent> <Up> gk
      imap <silent> <Up> <C-o>gk
      map <silent> <Down> gj
      imap <silent> <Down> <C-o>gj
      map <silent> <home> g<home>
      imap <silent> <home> <C-o>g<home>
      map <silent> <End> g<End>
      imap <silent> <End> <C-o>g<End>

      """"""""""""""" themes """""""""""""""
      syntax enable

      "set background=light
      set background=dark

      colorscheme angr

      """"""""""""""" airline """""""""""""""
      let g:airline_theme='angr'

      """"""""""""""" deoplete """""""""""""""
      let g:deoplete#enable_at_startup = 1
      if !exists('g:deoplete#omni#input_patterns')
        let g:deoplete#omni#input_patterns = {}
      endif

      """"""""""""""" fzf.vim """""""""""""""
      let g:fzf_command_prefix = 'FZF'

      """"""""""""""" haskell-vim """""""""""""""
      let g:haskell_classic_highlighting = 1
      let g:haskell_enable_quantification = 1
      let g:haskell_enable_recursivedo = 1
      let g:haskell_enable_arrowsyntax = 1
      let g:haskell_enable_pattern_synonyms = 1
      let g:haskell_enable_typeroles = 1
      let g:haskell_enable_static_pointers = 1
      let g:haskell_backpack = 1

      let g:haskell_indent_disable = 1

      """"""""""""""" ALE """""""""""""""
      let g:ale_linters = {
      \ 'haskell': ['hdevtools', 'hlint'],
      \ 'tex': ['chktex'],
      \}
      let g:ale_haskell_hdevtools_options = ""

      let g:ale_sign_column_always = 1
      let g:airline#extensions#ale#enabled = 1

      let g:ale_set_highlights = 0
      highlight clear ALEErrorSign
      highlight clear ALEWarningSign

      nmap <silent> <C-k> <Plug>(ale_previous_wrap)
      nmap <silent> <C-j> <Plug>(ale_next_wrap)

      augroup autocom
        au!
        " Stop the hdevtools server on quit
        autocmd VimLeave *.hs !hdevtools --stop-server
      augroup END

      """"""""""""""" neovim-ghci """""""""""""""
      augroup ghciMaps
        au!
        au FileType haskell nnoremap <silent> <leader>gs :GhciStart<CR>
        au FileType haskell nnoremap <silent> <leader>gk :GhciKill<CR>
        au FileType haskell nnoremap <silent> <leader>gr :GhciRestart<CR>
        au FileType haskell nnoremap <silent> <leader>go :GhciOpen<CR><C-W>H
        au FileType haskell nnoremap <silent> <leader>gh :GhciHide<CR>
        au FileType haskell nnoremap <silent> <leader>gl :GhciLoadCurrentModule<CR>
        au FileType haskell nnoremap <silent> <leader>gf :GhciLoadCurrentFile<CR>
        au BufWritePost *.hs GhciReload
      augroup END

      let g:ghci_command = 'ghci'
      let g:ghci_use_neomake = 0

      """"""""""""""" vimtex """""""""""""""
      let g:vimtex_enabled = 1
      let g:vimtex_compiler_progname = '${pkgs.neovim-remote}/bin/nvr'

      let g:vimtex_view_method = 'zathura'
      let g:vimtex_view_general_viewer = '${pkgs.zathura}'

      """"""""""""""" vimtex completion (deoplete) """""""""""""""
      let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
    '';

    vam.knownPlugins = pkgs.vimPlugins // extraPlugins;
    vam.pluginDictionaries = [
      { names = [
        "ale"
        "deoplete-nvim"
        "fzfWrapper"
        "fzf-vim"
        "haskell-vim"
        "neco-look"
        "neovim-ghci"
        "vimtex"
        "vim-airline"
        "vim-airline-themes"
        "vim-angr"
        "vim-nix"
        "vim-startify"
        "vim-stylish-haskell"
        ]; }
    ];
  };
  my-nvim = pkgs.neovim.override {
    vimAlias = true;
    configure = my-config;
  };
in my-nvim.overrideAttrs (old: {
})
