{ pkgs, ... }:

{
  home.packages = with pkgs; [
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      # Use the Nerd Font from fonts.nix for GNOME apps too:
      monospace-font-name = "JetBrainsMono Nerd Font 11";
    };
    "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,maximize,close";
    "org/gnome/desktop/calendar".show-weekdate = true;
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 4;
    };
  };

  programs.zsh.shellAliases = {
    dnfup = "sudo dnf upgrade --refresh";
  };
}
