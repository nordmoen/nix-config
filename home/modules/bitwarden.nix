{
  pkgs,
  isDarwin,
  ...
}:

{
  programs.rbw = {
    enable = true;

    settings = {
      email = "jorgen@nordmoen.net";
      lock_timeout = 300; # seconds
      pinentry = if isDarwin then pkgs.pinentry_mac else pkgs.pinentry-gnome3;
      base_url = "https://vault.nordmoen.net";
    };
  };
}
