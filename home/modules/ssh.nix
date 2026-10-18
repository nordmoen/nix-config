{
  config,
  lib,
  isDarwin,
  ...
}:

let
  inherit (config.home) homeDirectory;

  sshDir = "${homeDirectory}/.ssh";

  # rbw-agent ships a built-in SSH agent: the private key never leaves the
  # vault, rbw just signs the authentication challenge on our behalf.
  #   Linux: $XDG_RUNTIME_DIR/rbw/ssh-agent-socket
  #   macOS: $(getconf DARWIN_USER_TEMP_DIR)/rbw-$(id -u)/ssh-agent-socket
  # A named profile "work" would live in .../rbw-work/ssh-agent-socket instead.
  rbwSocketLinux = "$XDG_RUNTIME_DIR/rbw/ssh-agent-socket";
  rbwSocketDarwin = "$(getconf DARWIN_USER_TEMP_DIR)/rbw-$(id -u)/ssh-agent-socket";
in
{

  # ---------------------------------------------------------------------------
  # Point every SSH client at rbw's agent socket.
  # Home Manager's rbw module does NOT do this for you.
  # ---------------------------------------------------------------------------
  home.sessionVariables = lib.mkIf (!isDarwin) {
    SSH_AUTH_SOCK = rbwSocketLinux;
  };

  programs = {

    # ---------------------------------------------------------------------------
    # ~/.ssh/config
    # ---------------------------------------------------------------------------
    ssh = {
      enable = true;

      # Suppress Home Manager's implicit `Host *` block, which would otherwise
      # add a competing IdentityFile list.
      enableDefaultConfig = false;

      includes = [ "~/.ssh/config.local" ];

      settings = {
        # Defaults only. Deliberately no IdentityFile/IdentitiesOnly here:
        # rbw offers the vault's keys and selects the right one itself.
        "*" = {
          hashKnownHosts = true;
          serverAliveInterval = 60;
          serverAliveCountMax = 3;
          compression = false;
        };

        "router" = {
          hostname = "192.168.50.1";
          user = "root";
        };
      };
    };

    zsh = {
      shellAliases = {
        # Public halves straight from the agent — paste into GitHub/GitLab.
        "ssh-pub" = "ssh-add -L";
        "ssh-load" = "rbw unlock";
      };
      # macOS has no XDG_RUNTIME_DIR, so the path needs a command substitution
      # that sessionVariables can't express.
      initExtra = lib.mkIf isDarwin ''
        export SSH_AUTH_SOCK="${rbwSocketDarwin}"
      '';
    };
  };

  # ---------------------------------------------------------------------------
  # Housekeeping
  # ---------------------------------------------------------------------------
  home.activation.sshDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p "${sshDir}"
    run chmod 700 "${sshDir}"

    # Escape hatch for ad-hoc entries, never managed by Nix.
    if [ ! -e "${sshDir}/config.local" ]; then
      run touch "${sshDir}/config.local"
    fi
    run chmod 600 "${sshDir}/config.local"
  '';
}
