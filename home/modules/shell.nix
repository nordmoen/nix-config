{ ... }:

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
      hm-switch = "home-manager switch --flake ~/Projects/nix-config#\"$(whoami)@$(hostname -s)\"";
    };
    history = {
      size = 200000;
      save = 200000;
      extended = true;              # timestamps → atuin + `history -i`
      share = true;                 # default; live cross-session history
      ignoreDups = true;            # default
      ignoreAllDups = false;        # keep frequency data for atuin/fzf
      saveNoDups = true;            # tidy on-disk file
      findNoDups = false;           # keep up-arrow cycling predictable
      ignoreSpace = true;           # default; space-prefix = not recorded
      expireDuplicatesFirst = true; # trim dups before uniques
      ignorePatterns = [
        "rm *"
        "rm -rf *"
        "pkill *"
        "kill *"
      ];
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromTOML (builtins.readFile ./config/starship.toml);
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;

    # zsh integration generates the init hook in programs.zsh.initContent.
    # Defaults to true because zsh is enabled, but set it explicitly.
    enableZshIntegration = true;

    # Optional: pass flags to `zoxide init`.
    options = [ "--cmd cd" ]; # then `cd foo` jumps instead of `z foo`
  };
}
