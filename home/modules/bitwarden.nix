{
  pkgs,
  lib,
  isDarwin,
  ...
}:

{
  programs.rbw = {
    enable = true;

    settings = {
      email = "jorgen@nordmoen.net";
      lock_timeout = 300; # seconds
      # On GNOME/Fedora this is the right pinentry:
      pinentry = pkgs.pinentry-gnome3;
      base_url = "https://vault.nordmoen.net";
    };
  };
}
