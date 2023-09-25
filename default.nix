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

  copilot-lua = pkgs.vimUtils.buildVimPlugin rec {
    name = src.repo;
    src = pkgs.fetchFromGitHub {
      owner = "zbirenbaum";
      repo = "copilot.lua";
      rev = "2c942f33ba5c621c906e625e00a1bb504b65e2f0";
      sha256 = "sha256-YTq8bcPXKHT96sm+Ov5MulDvWzlK8BI3ehu8q4XDmzc=";
    };
  };

  modificator-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "modificator-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "mawkler";
      repo = "modicator.nvim";
      rev = "f0edf906a230a4ca37a32aa510d4cd346db46548";
      sha256 = "sha256-LTTqzNxkvGD8Niu+69OiRZuFWd+ikn/YNPFoYLI/ab4=";
    };
  };

  neovim = pkgs.neovim.override {
    configure = {
      customRC = ''
        lua << EOF
          package.path = package.path .. ';${./lua}/?.lua'; 
          local ok, err = pcall(function() require("custom-config") end)
          if not ok then 
            vim.api.nvim_err_writeln(err)
          end
        EOF
      '';

      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          comment-nvim
          copilot-lua
          coq-artifacts
          coq_nvim
          fidget-nvim
          gitsigns-nvim
          gruvbox
          indent-blankline-nvim
          lualine-nvim
          modificator-nvim
          neodev-nvim
          neoformat
          nui-nvim
          nvim-autopairs
          nvim-colorizer-lua
          nvim-lspconfig
          nvim-tree-lua
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
          plantuml-syntax
          plenary-nvim
          telescope-fzf-native-nvim
          telescope-nvim
          telescope-undo-nvim
          todo-comments-nvim
          toggleterm-nvim
          vim-ai
          vim-colorschemes
          vim-fugitive
          vim-obsession
          vim-rhubarb
          vim-tmux-navigator
          which-key-nvim
        ];
      };
    };
  };

  additionalPackages = with pkgs; [
    bash
    black
    entr
    fd
    git
    lazygit
    lua
    lua-language-server
    luaformatter
    neovim
    niv
    nixfmt
    nodejs
    nodePackages.pyright
    nodePackages.bash-language-server
    python311
    ripgrep
    shfmt
    which
    rust-analyzer
  ];
in pkgs.stdenv.mkDerivation {
  name = "nopevim";
  srcs = ./.;
  nativeBuildInputs = with pkgs; [ makeWrapper ];
  buildInputs = [ neovim ];

  postInstall = ''
    makeWrapper ${neovim}/bin/nvim $out/bin/nopevim \
      --prefix PATH : "${lib.makeBinPath additionalPackages}"
  '';
}
