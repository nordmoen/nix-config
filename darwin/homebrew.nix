{ ... }:
{
  homebrew = {
    enable = true;
    enableZshIntegration = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    caskArgs.no_quarantine = true;
    global.brewfile = true;

    casks = [
      # dev
      "docker"
      "docker-desktop"
      # Home server
      nextcloud
    ];
    brews = [
      "colima"
    ];
    taps = [
    ];
  };
}
