{ config, pkgs, lib, inputs, host, username, isDarwin, ... }:

{
  imports = [
    ./modules/dev.nix
    ./modules/editor.nix
    ./modules/git.nix
    ./modules/shell.nix
  ];

  # Set once here; bump deliberately when you want new defaults.
  home.stateVersion = "26.05";      # current HM release

  home.username     = username;
  home.homeDirectory =
    if isDarwin then "/Users/${username}" else "/home/${username}";

  # Let Home Manager manage itself (also gives you the `hm` CLI alias).
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER  = "less";
    HOST   = host;              # handy in prompts / scripts
  };

  home.packages = with pkgs; [
    bat
    eza
    fd
    fzf
    jq
    ripgrep
    zoxide
  ];
}
