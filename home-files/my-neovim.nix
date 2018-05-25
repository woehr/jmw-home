{ pkgs }:
let
  inherit (pkgs) fetchgit stdenv;
  inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;
  extraPlugins = {
    ghcid = buildVimPluginFrom2Nix {
      name = "ghcid";
      src = fetchgit {
        url = "https://github.com/ndmitchell/ghcid";
        rev = "af50233049183ad6977f8dec8597270a67ab3461";
        sha256 = "1k43mkk07rpx689aia3b156mpscvnagczvcbjnz5h4prz819r2av";
      } + "/plugins/nvim";
      dependencies = [];
    };
    neco-ghc = buildVimPluginFrom2Nix {
      name = "neco-ghc";
      src = fetchgit {
        url = "https://github.com/eagletmt/neco-ghc";
        rev = "682869aca5dd0bde71a09ba952acb59c543adf7d";
        sha256 = "1v7ibi4fp99s4lswz3v0gf4i0h5i5gpj05xpsf4cixwj2zgh206h";
      };
      dependencies = [];
    };
    lbnf = buildVimPluginFrom2Nix {
      name = "lbnf";
      src = fetchgit {
        url = "https://github.com/vim-scripts/lbnf.vim";
        rev = "6dabe6deb6369b608ca06f142c51cf8ce1ed5220";
        sha256 = "0csr3m9ipy1ix5zl97rgp87pg810rkm1r7mzffq15sxcl012vi1h";
      };
      dependencies = [];
    };
    neco-look = buildVimPluginFrom2Nix {
      name = "neco-look";
      src = fetchgit {
        url = "https://github.com/ujihisa/neco-look";
        rev = "ff3de2731177694d0e85f1227b6cfd51c8e2bc8d";
        sha256 = "0zpny9sj7alzsbrjbph71b44zf575hij1ky8pwgba0ygp2p2fxd4";
      };
      dependencies = [];
    };
#    neovim-ghci = buildVimPluginFrom2Nix {
#      name = "neovim-ghci";
#      src = fetchgit {
#        url = "https://github.com/owickstrom/neovim-ghci";
#        rev = "459c9584f6c816d6d60501ecb5bc746b69e30d0c";
#        sha256 = "0rmxr82b28c1px2vd3qb8671v79dn5bwl890pid0njl1c7dlmmgf";
#      };
#      dependencies = [];
#    };
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
      set title

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

      " ctrl-d and ctrl-u for page up/down in the popup menu
      inoremap <expr> <C-d> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
      inoremap <expr> <C-u> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

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
      map <silent> <Up> gk
      imap <silent> <Up> <C-o>gk
      map <silent> <Down> gj
      imap <silent> <Down> <C-o>gj
      map <silent> <Home> g<Home>
      imap <silent> <Home> <C-o>g<Home>
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

      """"""""""""""" fzf.vim """""""""""""""
      let g:fzf_command_prefix = 'FZF'
      command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

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

      let g:necoghc_enable_detailed_browse = 1

      " Disable haskell-vim omnifunc
      let g:haskellmode_completion_ghc = 0
      autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

      let g:ghcmod_ghc_options = [ '-ilib', '-isrc', '-itest' ]

      """"""""""""""" ALE """""""""""""""
      let g:ale_linters = {
      \ 'haskell': ['hdevtools', 'hlint'],
      \ 'tex': ['chktex'],
      \}

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

      au FileType haskell nnoremap <buffer> <leader>t :HdevtoolsType<CR>
      au FileType haskell nnoremap <buffer> <silent> <leader>ct :HdevtoolsClear<CR>

      """"""""""""""" ghcid """""""""""""""
      augroup ghciMaps
        au!
        au FileType haskell nnoremap <silent> <leader>gf :Ghcid <C-r>%<CR><C-w>H
        au FileType haskell nnoremap <silent> <leader>gk :GhcidKill<CR>
      augroup END

      """"""""""""""" vimtex """""""""""""""
      let g:vimtex_enabled = 1
      let g:vimtex_compiler_progname = '${pkgs.neovim-remote}/bin/nvr'

      let g:vimtex_view_method = 'zathura'
      let g:vimtex_view_general_viewer = '${pkgs.zathura}'

      if !exists('g:deoplete#omni#input_patterns')
        let g:deoplete#omni#input_patterns = {}
      endif
      let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
    '';

    vam.knownPlugins = pkgs.vimPlugins // extraPlugins;
    vam.pluginDictionaries = [
      { names =
        [ "ale"
          "deoplete-nvim"
          "fzfWrapper"
          "fzf-vim"
          "ghcid"
          "haskell-vim"
          "lbnf"
          "neco-ghc"
          "neco-look"
          #"neovim-ghci"
          "vimtex"
          "vim-airline"
          "vim-airline-themes"
          "vim-angr"
          "vim-hdevtools"
          "vim-nix"
          "vim-startify"
          "vim-stylish-haskell"
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
