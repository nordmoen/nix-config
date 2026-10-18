{
  pkgs,
  lib,
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
    ./modules/firefox.nix
    ./modules/fonts.nix
    ./modules/ghostty.nix
    ./modules/git.nix
    ./modules/shell.nix
    ./modules/ssh.nix
    ./modules/vscode.nix
  ]
  ++ lib.optional (!isDarwin) ./linux.nix;

  # Set once here; bump deliberately when you want new defaults.
  home = {
    stateVersion = "26.05";
    inherit username;
    homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
  };
  news.display = "silent";

  # Let Home Manager manage itself (also gives you the `hm` CLI alias).
  programs.home-manager.enable = lib.mkIf (!isDarwin) true;

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "less";
    HOST = host; # handy in prompts / scripts
  };

  home.packages = with pkgs; [
    bat
    bottom
    duckdb
    eza
    fd
    fzf
    jq
    ripgrep
  ];

  # English UI, Norwegian regional formats
  home.language = {
    base = "en_GB.UTF-8"; # LANG – fallback for anything unset below
    messages = "en_GB.UTF-8"; # LC_MESSAGES – application UI language
    ctype = "en_GB.UTF-8"; # LC_CTYPE
    collate = "en_GB.UTF-8"; # LC_COLLATE – alphabetical ordering

    time = "nb_NO.UTF-8"; # LC_TIME – dd.mm.yyyy, 24h clock
    numeric = "nb_NO.UTF-8"; # LC_NUMERIC – decimal comma
    monetary = "nb_NO.UTF-8"; # LC_MONETARY – NOK
    measurement = "nb_NO.UTF-8"; # LC_MEASUREMENT – metric
    paper = "nb_NO.UTF-8"; # LC_PAPER – A4
    name = "nb_NO.UTF-8"; # LC_NAME
    address = "nb_NO.UTF-8"; # LC_ADDRESS
    telephone = "nb_NO.UTF-8"; # LC_TELEPHONE
  };
}
