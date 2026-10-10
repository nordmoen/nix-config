{
  config,
  pkgs,
  lib,
  inputs,
  host,
  username,
  isDarwin,
  ...
}:

{
  imports = [
    ./modules/bitwarden.nix
    ./modules/dev.nix
    ./modules/editor.nix
    ./modules/fonts.nix
    ./modules/git.nix
    ./modules/shell.nix
    ./modules/vscode.nix
  ]
  ++ lib.optional (!isDarwin) ./linux.nix;

  # Set once here; bump deliberately when you want new defaults.
  home.stateVersion = "26.05";
  news.display = "silent";

  home.username = username;
  home.homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";

  # Let Home Manager manage itself (also gives you the `hm` CLI alias).
  programs.home-manager.enable = lib.mkIf (!isDarwin) true;

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "less";
    HOST = host; # handy in prompts / scripts
  };

  home.packages = with pkgs; [
    bat
    duckdb
    eza
    fd
    fzf
    jq
    ripgrep
  ];
}
