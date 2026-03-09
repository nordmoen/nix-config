{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # dev tools
      bat
      curl
      eza
      fzf
      just
      ripgrep
      uv
      zoxide
      zstd

      # Terminal
      helix
      ghostty

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
