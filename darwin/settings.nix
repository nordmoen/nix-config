{ self, ... }:
{
  # touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # system defaults and preferences
  system = {
    stateVersion = 6;
    configurationRevision = self.rev or self.dirtyRev or null;

    startup.chime = false;

    defaults = {
      menuExtraClock.Show24Hour = true;

      loginwindow = {
        GuestEnabled = false;
        DisableConsoleAccess = true;
      };

      dock = {
        persistent-apps = [
          "/Applications/Firefox.app"
          "/Applications/Ghostty.app"
          "/Applications/Visual Studio Code.app"
          "/Applications/Microsoft Outlook.app"
          "/Applications/Slack.app"
          "/Applications/Microsoft Teams.app"
          "/System/Applications/System Settings.app"
        ];
      };

      finder = {
        _FXShowPosixPathInTitle = true; # title bar full path
        ShowPathbar = true; # breadcrumb nav at bottom
        ShowStatusBar = true; # file count & disk space
        FXPreferredViewStyle = "clmv"; # Column view
      };

      NSGlobalDomain = {
        "com.apple.swipescrolldirection" = true; # enable natural scrolling(default to true)
        "com.apple.sound.beep.feedback" = 0; # disable beep sound when pressing volume up/down key
        "com.apple.keyboard.fnState" = false; # Use media keys by default
        AppleInterfaceStyle = "Dark"; # dark mode

        # Interface settings
        AppleShowAllExtensions = true;
        AppleShowAllFiles = false;

        # Disable automatic features
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;

        # Screen saver settings
        screensaver = {
          askForPassword = true;
          askForPasswordDelay = 0;
        };

        # Screenshot settings
        screencapture = {
          location = "~/Pictures/Screenshots";
          type = "png";
          disable-shadow = true;
        };
        # Custom user preferences
        CustomUserPreferences = {
          # Disable annoying features
          "com.apple.AdLib" = {
            allowApplePersonalizedAdvertising = false;
          };

          # Speed up Mission Control animations
          "com.apple.dock" = {
            expose-animation-duration = 0.1;
          };

          # 24-hour clock in menu bar
          "com.apple.menuextra.clock" = {
            Show24Hour = true;
            ShowAMPM = false;
          };

          # Require password immediately after sleep or screen saver begins
          "com.apple.screensaver" = {
            askForPassword = 1;
            askForPasswordDelay = 0;
          };
        };
      };
    };
  };
}
