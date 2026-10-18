_: {
  programs = {
    git = {
      enable = true;

      settings = {
        user.name = "Jørgen Nordmoen";
        user.email = "jorgen@nordmoen.net";
        github.user = "nordmoen";

        color.ui = true;
        core.editor = "nvim";
        init.defaultBranch = "main";
        pull.rebase = true;
      };
    };

    lazygit = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        gui.theme = {
          activeBorderColor = [
            "green"
            "bold"
          ];
          inactiveBorderColor = [ "default" ];
        };
        git.diffRenderers = [
          {
            colorArg = "always";
            command = "delta --paging=never";
          }
        ];
        confirmOnQuit = false;
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        features = "decorations";
        navigate = true;
        side-by-side = true;
        line-numbers = true;
        syntax-theme = "Catppuccin Frappe";
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-style = "bold yellow ul";
          file-decoration-style = "none";
        };
      };
    };
  };
}
