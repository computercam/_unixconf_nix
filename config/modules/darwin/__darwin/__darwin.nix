{ config, lib, pkgs, ... }:
with lib;
let
in {
  config = {
    system.defaults = {
      NSGlobalDomain = {
        AppleMeasurementUnits = "Inches";
        AppleTemperatureUnit = "Fahrenheit";
        NSAutomaticWindowAnimationsEnabled = false;
        NSScrollAnimationEnabled = false;
        NSWindowResizeTime = "0.001";
        NSUseAnimatedFocusRing = false;
        _HIHideMenuBar = true;
        "com.apple.swipescrolldirection" = false;
      };

      alf = {
        stealthenabled = 1;
        loggingenabled = 1;
      };

      finder = {
        CreateDesktop = false;
      };

      dock = {
        autohide = true;
        autohide-delay = "0.00";
        autohide-time-modifier = "0.00";
        expose-animation-duration = "0.00";
        minimize-to-application = true;
        mru-spaces = false;
        tilesize = 16;
        orientation = "left";
      };

      finder = {
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        QuitMenuItem = true;
        _FXShowPosixPathInTitle = true;
      };

      spaces.spans-displays = false;
    };

    system.keyboard = { enableKeyMapping = true; };
  };
}
