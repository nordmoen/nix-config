{ ... }:
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

      spell = true;
      spelllang = [
        "en"
        "nb"
      ];
      spelloptions = "camel";
    };

    clipboard.register = "unnamedplus";

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "frappe";
    };

    # ---- Quality-of-life plugins -----------------------------------
    plugins = {
      lspconfig.enable = true;

      treesitter = {
        enable = true;
        settings.ensure_installed = [
          "bash"
          "dockerfile"
          "javascript"
          "json"
          "markdown"
          "nix"
          "python"
          "rust"
          "sql"
          "toml"
          "typescript"
          "yaml"
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

    lsp = {
      servers = {
        # Combine `pyright` and `ruff` by turning off `ruff` responsibility
        # in `pyright`
        pyright = {
          enable = true;
          config = {
            pyright.disableOrganizeImports = true;
            python.analysis.ignore = [ "*" ];
          };
        };
        ruff.enable = true;

        gh_actions_ls.enable = true;
        nil_ls.enable = true;
        rumdl.enable = true;
        ts_ls.enable = true;
      };
      keymaps = [
        {
          key = "<leader>ca";
          lspBufAction = "code_action";
        }
        {
          key = "<leader>rn";
          lspBufAction = "rename";
        }
        {
          key = "gd";
          lspBufAction = "definition";
        }
        {
          key = "gD";
          lspBufAction = "references";
        }
        {
          key = "K";
          lspBufAction = "hover";
        }
      ];
    };

    extraConfigLua = ''
      -- Nixvim strips the 'site' dir from runtimepath; put it back so
      -- both the Norwegian (nb) and dirtytalk (programming) spell files
      -- can be found/downloaded.
      vim.opt.runtimepath:prepend(vim.fs.joinpath(vim.fn.stdpath("data"), "site"))

      -- Re-assert 'camel' since treesitter sets 'noplainbuffer'.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          vim.opt_local.spelloptions:append("camel")
        end,
      })
    '';
  };
}
