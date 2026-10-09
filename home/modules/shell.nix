{ pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      la = "eza -la";
      ll = "eza -l";
      ls = "eza";
      tree = "eza --tree";
      hm-switch = "home-manager switch --flake ~/nix-config#\"$(whoami)@$(hostname -s)\""
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      hostname.ssh_only = true;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}

