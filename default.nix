{ pkgs ? import <nixpkgs> { }, lib ? pkgs.lib }:

let
  vim-ai = pkgs.vimUtils.buildVimPlugin {
    name = "vim-ai";
    src = pkgs.fetchFromGitHub {
      owner = "madox2";
      repo = "vim-ai";
      rev = "924e3a390f043e979f16113f6b0a55f8c54b1f5e";
      sha256 = "sha256-8LxxT6i2io+GlEHtj31a0+kH5zX4mL4fFLUY5yNs8fM=";
    };
  };

  neovim0 = pkgs.neovim.override {
    configure = {
      customRC = ''
        function! Init()
          let files = split(glob('${./config}/*'), '\n')
          for file in files
            let extension = fnamemodify(file, ':e')
            if extension == 'lua'
              execute 'luafile ' . file
            elseif extension == 'vim'
              execute 'source ' . file
            endif
            echo "Processed file: " . file
          endfor
        endfunction

        autocmd VimEnter * call Init()
      '';

      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          coq-artifacts
          coq_nvim
          fidget-nvim
          gitsigns-nvim
          gruvbox
          indent-blankline-nvim
          lualine-nvim
          neo-tree-nvim
          neodev-nvim
          neoformat
          nerdtree
          nui-nvim
          nvim-autopairs
          nvim-colorizer-lua
          nvim-comment
          nvim-lspconfig
          nvim-treesitter
          nvim-treesitter-parsers.awk
          nvim-treesitter-parsers.bash
          nvim-treesitter-parsers.c
          nvim-treesitter-parsers.c_sharp
          nvim-treesitter-parsers.comment
          nvim-treesitter-parsers.css
          nvim-treesitter-parsers.diff
          nvim-treesitter-parsers.dockerfile
          nvim-treesitter-parsers.erlang
          nvim-treesitter-parsers.fish
          nvim-treesitter-parsers.gitattributes
          nvim-treesitter-parsers.gitignore
          nvim-treesitter-parsers.go
          nvim-treesitter-parsers.gomod
          nvim-treesitter-parsers.gosum
          nvim-treesitter-parsers.haskell
          nvim-treesitter-parsers.hcl
          nvim-treesitter-parsers.html
          nvim-treesitter-parsers.htmldjango
          nvim-treesitter-parsers.ini
          nvim-treesitter-parsers.json
          nvim-treesitter-parsers.jsonnet
          nvim-treesitter-parsers.latex
          nvim-treesitter-parsers.lua
          nvim-treesitter-parsers.make
          nvim-treesitter-parsers.markdown
          nvim-treesitter-parsers.markdown_inline
          nvim-treesitter-parsers.nix
          nvim-treesitter-parsers.python
          nvim-treesitter-parsers.regex
          nvim-treesitter-parsers.rust
          nvim-treesitter-parsers.sql
          nvim-treesitter-parsers.starlark
          nvim-treesitter-parsers.terraform
          nvim-treesitter-parsers.toml
          nvim-treesitter-parsers.typescript
          nvim-treesitter-parsers.vim
          nvim-treesitter-parsers.yaml
          nvim-treesitter-textobjects
          nvim-web-devicons
          onedark-vim
          plenary-nvim
          telescope-fzf-native-nvim
          telescope-nvim
          toggleterm-nvim
          vim-ai
          vim-colorschemes
          vim-fugitive
          vim-rhubarb
          vim-sleuth
          which-key-nvim
        ];
      };
    };
  };

  neovim = neovim0.overrideAttrs (finalAttrs: previousAttrs: {
    buildInputs = previousAttrs.buildInputs or [ ] ++ [
      pkgs.which
      pkgs.git
      pkgs.ripgrep
      pkgs.fd
      pkgs.lazygit
      pkgs.python311
      pkgs.niv
      pkgs.neovim
      pkgs.lua
      pkgs.luaformatter
      pkgs.black
      pkgs.nixfmt
    ];
  });
  additionalPackages = [
    pkgs.bash
    pkgs.black
    pkgs.fd
    pkgs.git
    pkgs.lazygit
    pkgs.lua
    pkgs.luaformatter
    pkgs.neovim
    pkgs.niv
    pkgs.nixfmt
    pkgs.python311
    pkgs.ripgrep
    pkgs.which
];
in 
pkgs.stdenv.mkDerivation {
  name = "nopevim";
  srcs = ./.;
  nativeBuildInputs = with pkgs; [ makeWrapper ];
  buildInputs = [ neovim ];

  postInstall = ''
    makeWrapper ${neovim}/bin/nvim $out/bin/nopevim \
      --prefix PATH : "${lib.makeBinPath additionalPackages }"
    exit 0
  '';
}
