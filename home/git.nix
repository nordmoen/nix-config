{ primaryUser, ... }:
{
  programs.git = {
    enable = true;
    userName = "Jørgen Nordmoen";
    userEmail = "jorgen@nordmoen.net";

    lfs.enable = true;

    ignores = [ "**/.DS_STORE" ];

    extraConfig = {
      github = {
        user = "nordmoen";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
