{ config, lib, pkgs, ... }:

with pkgs.stdenv;
with lib;

let cfg = config.cfg;
in {
  options.cfg.os = {
    arch = mkOption {
      type = types.str;
      default = "x86-64";
      description = "System Architecture";
    };

    family = mkOption {
      type = types.str;
      default = "generic";
      description = "Operating System Unix Family";
    };

    version = mkOption {
      type = types.str;
      default = "latest";
      description = "Operating System Type";
    };
  };

  options.cfg.localization = {
    lang = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
      description = "System Language";
    };

    timezone = mkOption {
      type = types.str;
      default = "America/Chicago";
      description = "System Default Timezone";
    };

    keymap = mkOption {
      type = types.str;
      default = "us";
      description = "Console Keymap";
    };

    longitude = mkOption {
      type = types.flt;
      default = 32.0;
      description = "Location Long";
    };

    latitude = mkOption {
      type = types.flt;
      default = -96.0;
      description = "Location Lat";
    };
  };

  config = {
    environment.variables.LANG = cfg.localization.lang;
    i18n.defaultLocale = cfg.localization.lang;
    location.latitude = cfg.localization.latitude;
    location.longitude = cfg.localization.longitude;

    nix.allowedUsers =
      if isLinux then [ "@wheel" ] else if isDarwin then [ "@staff" ] else [ ];

    nixpkgs.config.allowUnfree = true;
    time.timeZone = cfg.localization.timezone;

    environment.systemPackages = with pkgs; [ nixfmt git vim ];
  };
}
