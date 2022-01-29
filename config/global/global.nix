{ config, lib, pkgs, ... }:

with pkgs.stdenv; 
with lib;

let
  cfg = config.cfg;
  homeDir = builtins.getEnv("HOME");
in
{
  options = {
    cfg.os = {
      arch = mkOption {
        type = types.str;
        default = "x86-64";
        description = "System Architecture";
      };

      family = mkOption {
        type = types.str;
        default = "linux";
        description = "Operating System Unix Family";
      };

      version = mkOption {
        type = types.str;
        default = "latest";
        description = "Operating System Type";
      };
    };

    cfg.lang = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
      description = "System Language";
    };

    cfg.timezone = mkOption {
      type = types.str;
      default = "America/Chicago";
      description = "System Default Timezone";
    };

    cfg.keymap = mkOption {
      type = types.str;
      default = "us";
      description = "Console Keymap";
    };

    cfg.longitude = mkOption {
      type = types.flt;
      default = 32.0;
      description = "Location Long";
    };
    
    cfg.latitude = mkOption {
      type = types.flt;
      default = -96.0;
      description = "Location Lat";
    };
  };

  config = {
    environment.variables.LANG = cfg.lang;
    i18n.defaultLocale = cfg.lang;
    location.latitude = cfg.latitude;
    location.longitude = cfg.longitude;
    nix.allowedUsers = [ "@wheel" "@staff" ];
    nixpkgs.config.allowUnfree = true;
    time.timeZone = cfg.timezone;
  };
}
