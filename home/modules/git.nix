{ ... }:

{
  programs.git = {
    enable = true;
    userName  = "Jørgen Nordmoen";
    userEmail = "jorgen@nordmoen.net";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      core.editor = "nvim";
    };
  };
}

