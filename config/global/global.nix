{ config, lib, pkgs, ... }:

with pkgs.stdenv;
with lib;

let 
  isLinux = strings.hasSuffix "linux" builtins.currentSystem;
  isDarwin = strings.hasSuffix "darwin" builtins.currentSystem;

  unix = if isLinux then "linux" 
        else if isDarwin then "darwin" 
        else "generic";
  distro = if isLinux then "nixos" 
        else if isDarwin then "macos" 
        else "generic";
in {
  options.cfg.os = {
    arch = mkOption {
      type = types.str;
      default = "x86-64";
      description = "System Architecture";
    };

    unix = mkOption {
      type = types.str;
      default = unix;
      description = "Operating System Unix Family";
    };

    distro = mkOption {
      type = types.str;
      default = distro;
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

  config = (mkMerge [ 
    (if unix == "linux" then {
      i18n.defaultLocale = config.cfg.localization.lang;
      location.latitude = config.cfg.localization.latitude;
      location.longitude = config.cfg.localization.longitude;
      
      nix.allowedUsers =  [ "@wheel" ] ;
    } else {})
    (if unix == "darwin" then {
      nix.allowedUsers = [ "@staff" ];
    } else {})
    ({
      environment.systemPackages = with pkgs; [ 
        age
        git 
        nixfmt
        vim
      ];
      environment.variables.LANG = config.cfg.localization.lang;
      nixpkgs.config.allowUnfree = true;
      time.timeZone = config.cfg.localization.timezone;
    })
  ]);
}
