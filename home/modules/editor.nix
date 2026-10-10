{
  pkgs,
  lib,
  config,
  inputs,
  isDarwin,
  ...
}:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true; # sets $EDITOR / manpager via HM
    viAlias = true;
    vimAlias = true;

    # Reuse Home Manager's pkgs instead of nixvim building its own.
    nixpkgs.useGlobalPackages = true;

    # ---- Leader + core options -------------------------------------
    globals.mapleader = " ";
    globals.maplocalleader = " ";

    opts = {
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartindent = true;
      termguicolors = true;
      clipboard = "unnamedplus";
      signcolumn = "yes";
      updatetime = 250;
      splitright = true;
      splitbelow = true;
      wrap = false;
    };

    clipboard.register = "unnamedplus";

    colorschemes.catppuccin.enable = true;

    # ---- Quality-of-life plugins -----------------------------------
    plugins = {
      lsp.enable = true;

      treesitter = {
        enable = true;
        settings.ensure_installed = [
          "python"
          "nix"
          "lua"
          "bash"
          "json"
          "yaml"
          "toml"
          "markdown"
        ];
      };

      telescope.enable = true;
      gitsigns.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;
      nvim-autopairs.enable = true;
      comment.enable = true;

      lualine = {
        enable = true;
        settings.options.theme = "auto";
      };

      # Fuzzy file finder keymaps
      telescope.keymaps = {
        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
        "<leader>fb" = "buffers";
      };
    };
  };
}
