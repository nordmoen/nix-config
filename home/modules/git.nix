{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Jørgen Nordmoen";
      user.email = "jorgen@nordmoen.net";
      init.defaultBranch = "main";
      pull.rebase = true;
      core.editor = "nvim";
    };
  };
}
