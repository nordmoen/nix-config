{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # dev tools
      bat
      curl
      eza
      fd
      fzf
      just
      ripgrep
      rumdl
      uv
      zoxide
      zstd

      # Applications
      firefox
      slack
      vscode

      # Terminal
      helix

      # Home server
      bitwarden-desktop
      wireguard-ui

      # misc
      nixfmt-rfc-style

      # fonts
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
    ];
  };
}
