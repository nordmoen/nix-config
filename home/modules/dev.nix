{ pkgs, config, lib, ... }:

{
  # ---- Always-on system/build tooling: keep in Nix ------------------
  home.packages = with pkgs; [
    git gh
    gcc gnumake pkg-config   # build deps for native extensions
    nil nixpkgs-fmt          # nix LSP + formatter
  ];

  # ---- Language runtimes & dev CLIs: delegate to mise ---------------
  programs.mise = {
    enable = true;

    # Keep config.toml writable so `mise use --global` still works.
    # Home Manager then writes its own settings to
    # $XDG_CONFIG_HOME/mise/conf.d/50-home-manager.toml instead.
    mutableSettings = true;

    # Shell hook so mise auto-switches tools per directory.
    enableZshIntegration = true;   # (add enableBashIntegration if you use bash)

    # Global (machine-wide) defaults. These are the fallback versions;
    # any repo's mise.toml / .tool-versions overrides them.
    globalConfig = {
      settings = {
        lockfile = true;
        minimum_release_age = "7d";
        experimental = true;       # enables the newer mise features
        verbose = false;
        idiomatic_version_file_enable_tools = [ "python" ];  # read .python-version
      };

      # Optional: rename a tool for convenience
      # tool_alias.node.versions.my_node = "20";
    };
  };
}

