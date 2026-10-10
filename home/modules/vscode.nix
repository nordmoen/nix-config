{
  pkgs,
  lib,
  isDarwin,
  ...
}:

{
  programs.vscode = {
    enable = true;

    # MUST be the Microsoft build: Settings Sync needs MS auth servers.
    package = pkgs.vscode;

    # Extensions dir stays writable -> marketplace UI + Sync can manage it.
    mutableExtensionsDir = true;

    # argv.json is NOT part of Settings Sync, so it's safe to keep in Nix.
    # Needed so the one-time login succeeds on Fedora's keyring.
    argvSettings = lib.mkIf (!isDarwin) {
      "password-store" = "gnome-libsecret";
    };

    # NO `profiles`, NO `extensions`, NO `userSettings`.
  };
}
