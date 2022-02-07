{ config, lib, pkgs, ... }:

with pkgs.stdenv;
with lib; {
  options.cfg.os = {
    arch = mkOption {
      type = types.str;
      default = "x86-64";
      description = "System Architecture";
    };

    family = mkOption {
      type = types.str;
      default =
        if isLinux then "linux" else if isDarwin then "darwin" else "unix";
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
}
