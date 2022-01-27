{ config, lib, pkgs, ... }:

with pkgs.stdenv; 
with lib;

let
  cfg = config.cfg;
  homeDir = builtins.getEnv("HOME");
in
{
  options = {
    cfg.systemname= mkOption {
      type = types.str;
      description = "Target system to build.";
    };

    cfg.lang = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
      description = "System Language";
    };

    cfg.timezone = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
      description = ""America/Chicago"";
    };
  };

  config = {
    ## Nix Settings
    nix = {
      allowedUsers = [
        "@wheel" 
      ];
      
      buildCores = 0;
    };

    nixpkgs.config.allowUnfree = true;
    networking.hostName = cfg.systemname;

    ## Localization
    environment.variables.LANG = cfg.lang;
    time.timeZone = cfg.timezone;
  };
}
