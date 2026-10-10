{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installBatSyntax = true;
    clearDefaultKeybinds = false;

    settings = {
      theme = "Catppuccin Frappe"; # built-in; no plugin needed
      font-family = [
        "JetBrainsMono Nerd Font" # primary (falls back if absent)
        "JetBrains Mono"
        "Noto Color Emoji" # emoji fallback on Linux
      ];
      font-size = 12;
      font-feature = [ "-calt" ]; # use "+liga" if you want ligatures
      adjust-cell-height = "10%"; # roomier lines

      background-opacity = 0.94;
      # background-blur = 20;            # option name varies by Ghostty version

      window-padding-x = 10;
      window-padding-y = 8;
      window-padding-balance = true;

      # --- behaviour ---
      cursor-style = "block";
      cursor-style-blink = false;
      mouse-hide-while-typing = true;
      copy-on-select = "clipboard"; # middle-click still uses selection
      confirm-close-surface = false;
      scrollbar = "never";

      # --- GNOME: no server-side decorations, keep it clean ---
      window-decoration = "auto";
      gtk-titlebar = false;

      # --- shell integration (zsh + Starship) ---
      shell-integration = "zsh"; # default is "detect"; explicit is fine

      # --- keybinds (splits like tmux, but no leader needed) ---
      keybind = [
        "ctrl+shift+enter=new_split:right"
        "ctrl+shift+backslash=new_split:down"
        "ctrl+shift+h=goto_split:left"
        "ctrl+shift+l=goto_split:right"
        "ctrl+shift+k=goto_split:top"
        "ctrl+shift+j=goto_split:bottom"
        "ctrl+shift+t=new_tab"
        "ctrl+shift+w=close_surface"
        "ctrl+shift+f=toggle_fullscreen"
        "ctrl+shift+plus=increase_font_size:1"
        "ctrl+shift+minus=decrease_font_size:1"
        "ctrl+shift+0=reset_font_size"
      ];
    };
  };
}
