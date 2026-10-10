{ ... }:

{
  programs.git = {
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
}
