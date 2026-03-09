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
      # messaging
      "slack"
      # dev
      "docker"
      "docker-desktop"
      "visual-studio-code"
    ];
    brews = [
      "colima"
    ];
    taps = [
    ];
  };
}
