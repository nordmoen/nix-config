{ lib, pkgs, ... }:

{
  targets.genericLinux.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      # Use the Nerd Font from fonts.nix for GNOME apps too:
      monospace-font-name = "JetBrainsMono Nerd Font 11";
    };
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 4;
      button-layout = "appmenu:minimize,maximize,close";
    };
    "system/locale" = {
      region = "nb_NO.UTF-8";
    };
    "org/gnome/desktop/input-sources" = {
      sources = [
        (lib.hm.gvariant.mkTuple [
          "xkb"
          "no"
        ])
      ];
    };
  };

  programs.zsh.shellAliases = {
    dnfup = "sudo dnf upgrade --refresh";
  };

  # Linux services or programs that should not be installed on other hosts
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };

  home.packages = with pkgs; [
    evolution
  ];
}
