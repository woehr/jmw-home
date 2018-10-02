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
    name = "deoplete-nvim-2018-10-02";
    src = fetchgit {
      url = "https://github.com/Shougo/deoplete.nvim";
      rev = "98ffe701a8c3b6b6371cd02c293fe03fbf86fb76";
      sha256 = "1snk7prv0pzfzjy2j1skbirr3gqs37cn2v9lb770wjz0k2ky0hd4";
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
    name = "vimtex-2018-09-28";
    src = fetchgit {
      url = "https://github.com/lervag/vimtex";
      rev = "196a8aa7e9f9d04c69adfa7643b0e6ae6b0d3b3b";
      sha256 = "0d7322cflmi3sxh6nncslp3qdgd766k2mcplgji2744xff65bvma";
    };
    dependencies = [];

  };

  ghcid = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "ghcid-2018-09-23";
    src = fetchgit {
      url = "https://github.com/ndmitchell/ghcid";
      rev = "811933812935d2b2135cc3972f921fb4b214bb37";
      sha256 = "1sxd6m6jxm9kvncg77sll9j5q4s7d506siymvh5agkzyymz9lkba";
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

  vim-airline = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-airline-2018-09-25";
    src = fetchgit {
      url = "https://github.com/vim-airline/vim-airline";
      rev = "a0298263b7fd55827839862ffd3a8d5b2a787a5c";
      sha256 = "115mwvkqhfrssihrlb1ds3f82gqmp6ph75nw24l4lwdr1nv6p1r0";
    };
    dependencies = [];

  };

  vim-airline-themes = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-airline-themes-2018-09-05";
    src = fetchgit {
      url = "https://github.com/vim-airline/vim-airline-themes";
      rev = "725789c110fbab52f8c18021f9d043839d7e31ed";
      sha256 = "15k5s8yysnvm0swfi27g2yhrnkb8kzvswb58k1jbzb65nwdw139z";
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
    name = "ale-2018-10-02";
    src = fetchgit {
      url = "https://github.com/w0rp/ale";
      rev = "ab3646862cb180d56e079465cdea2830ff172334";
      sha256 = "06mxlchwx7mwaisz3p5rbll6kgf2s9jg8bl4i5xx9dn7dlac5b5n";
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
