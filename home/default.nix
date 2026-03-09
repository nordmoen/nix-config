{ primaryUser, ... }:
{
  imports = [
    ./ghostty.nix
    ./git.nix
    ./helix.nix
    ./packages.nix
    ./shell.nix
    ./zoxide.nix
  ];

  home = {
    username = primaryUser;
    stateVersion = "25.11";
    sessionVariables = {
      # shared environment variables
      PIP_REQUIRE_VIRTUALENV=true;
    };

    # create .hushlogin file to suppress login messages
    file.".hushlogin".text = "";
  };
}
