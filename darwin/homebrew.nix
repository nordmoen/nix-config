{ ... }:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    caskArgs.no_quarantine = true;
    global.brewfile = true;

    casks = [
      # messaging
      "slack"
      # dev
      "docker"
      "docker-desktop"
    ];
    brews = [
      "colima"
    ];
    taps = [
    ];
  };
}
