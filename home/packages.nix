{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # dev tools
      bat
      curl
      eza
      just
      ripgrep
      uv
      zstd

      # Home server
      bitwarden-desktop
      nextcloud-client
      wireguard-ui

      # misc
      nixfmt-rfc-style

      # fonts
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
    ];
  };
}
