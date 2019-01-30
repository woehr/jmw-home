{ fetchgit, buildVimPluginFrom2Nix }:
{
  vim-nix = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-nix-2018-08-27";
    src = fetchgit {
      url = "https://github.com/LnL7/vim-nix";
      rev = "be0c6bb409732b79cc86c177ca378b0b334e1efe";
      sha256 = "1ivkwlm6lz43xk1m7aii0bgn2p3225dixck0qyhxw4zxhp2xiz06";
    };
    dependencies = [];

  };

  deoplete-nvim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "deoplete-nvim-2018-11-22";
    src = fetchgit {
      url = "https://github.com/Shougo/deoplete.nvim";
      rev = "f1148807bdd95877990b4b46c28ad46dc9e140ce";
      sha256 = "0syihrd0d73v51qjxd7blyxicw2xxbkyf4b13vb7qnvih7gpcglw";
    };
    dependencies = [];

  };

  alex-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "alex-vim-2015-02-08";
    src = fetchgit {
      url = "https://github.com/andy-morris/alex.vim";
      rev = "bd95024624b297e212e57582a1ece21ac5dab6b8";
      sha256 = "19m1c2wrza6srp8ylinsz5nrjzy3mrb1dc1nmjm23blx1lg8ql5h";
    };
    dependencies = [];

  };

  happy-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "happy-vim-2017-08-24";
    src = fetchgit {
      url = "https://github.com/andy-morris/happy.vim";
      rev = "d5edc4efdfcf52258a0233e67cbd4f35029eb238";
      sha256 = "005s1hr7lxfl9wwn9lzr9axpj3cl7lj29i1681jw63vlzbpr4d2v";
    };
    dependencies = [];

  };

  neco-ghc = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "neco-ghc-2018-05-13";
    src = fetchgit {
      url = "https://github.com/eagletmt/neco-ghc";
      rev = "682869aca5dd0bde71a09ba952acb59c543adf7d";
      sha256 = "1v7ibi4fp99s4lswz3v0gf4i0h5i5gpj05xpsf4cixwj2zgh206h";
    };
    dependencies = [];

  };

  vimtex = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vimtex-2018-11-19";
    src = fetchgit {
      url = "https://github.com/lervag/vimtex";
      rev = "3da816cf29e360b502f538faaf263ce66f15f89d";
      sha256 = "1iinvwm14cmcpmxpw6jmqglx7iqs2q3cb0a0qs1pwb1bk0789zzl";
    };
    dependencies = [];

  };

  ghcid = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "ghcid-2018-10-15";
    src = fetchgit {
      url = "https://github.com/ndmitchell/ghcid";
      rev = "0ad2de5990feeb9b551bd1470455e3cdd742afbc";
      sha256 = "072d76psskkqkyqsmagm35axb9cg551ii165c3cdb0gh6rb24ldb";
    };
    dependencies = [];

  };

  haskell-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "haskell-vim-2018-05-22";
    src = fetchgit {
      url = "https://github.com/neovimhaskell/haskell-vim";
      rev = "b1ac46807835423c4a4dd063df6d5b613d89c731";
      sha256 = "1vqj3r2v8skffywwgv4093ww7fm540437j5qz7n8q8787bs5w0br";
    };
    dependencies = [];

  };

  vim-vue = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-vue-2018-11-11";
    src = fetchgit {
      url = "https://github.com/posva/vim-vue";
      rev = "e306929b27bea08ab505de7a4617e642b56b6dcd";
      sha256 = "1k48z8b6xmgqdcixx7yhbcf0jcyyfqv0zwijfq2j05559r9myx16";
    };
    dependencies = [];

  };

  vim-airline = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-airline-2018-11-22";
    src = fetchgit {
      url = "https://github.com/vim-airline/vim-airline";
      rev = "bd468dacfe874fd669ec69522b550d3e1371cf56";
      sha256 = "0a92a42xnx0rif7r85mrp7jhzmlnbaiqafpc8bn1848bbq9wg880";
    };
    dependencies = [];

  };

  vim-airline-themes = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-airline-themes-2018-11-15";
    src = fetchgit {
      url = "https://github.com/vim-airline/vim-airline-themes";
      rev = "3bfe1d00d48f7c35b7c0dd7af86229c9e63e14a9";
      sha256 = "1zwygmwa7gqppa49d2rsdwk5zv8rzj059bbclhs492bmbb5wyyz8";
    };
    dependencies = [];

  };

  lbnf-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "lbnf-vim-2010-10-17";
    src = fetchgit {
      url = "https://github.com/vim-scripts/lbnf.vim";
      rev = "6dabe6deb6369b608ca06f142c51cf8ce1ed5220";
      sha256 = "0csr3m9ipy1ix5zl97rgp87pg810rkm1r7mzffq15sxcl012vi1h";
    };
    dependencies = [];

  };

  ale = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "ale-2018-11-21";
    src = fetchgit {
      url = "https://github.com/w0rp/ale";
      rev = "ff0bd14efe8ba55594afe5175f562254d5268689";
      sha256 = "0ljdki0smxydrm9xlmky7lcvxcad8crlh5y21v7v0dgsf29jazl4";
    };
    dependencies = [];

  };

  angr-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "angr-vim-2018-07-22";
    src = fetchgit {
      url = "https://github.com/zacanger/angr.vim";
      rev = "8c6eb8f1d8d4642bd2c6ba7a32fd0b2b68297830";
      sha256 = "1767m8qx0xwbpaxxwzplaxrf9849dli7q860s06nyxj2lfq0g066";
    };
    dependencies = [];

  };
}
