{ config, lib, pkgs, ... }:

with pkgs.stdenv; 
with lib;

let
  cfg = config.cfg;
  homeDir = builtins.getEnv("HOME");
in
{
  options = {
    cfg.username = mkOption {
      type = types.str;
      default = "cameron";
      description = "Username for the main user on the system";
    };

    cfg.userfullname = mkOption {
      type = types.str;
      default = "Cameron Sanders";
      description = "Username for the main user on the system";
    };

    cfg.useremail = mkOption {
      type = types.str;
      default = "csanders@protonmail.com";
      description = "Email for the main user on the system";
    };
  };

  config = {
    nix = {
      allowedUsers = [ 
        "${cfg.username}"
      ];
    };

    users.users."${cfg.username}" = mkMerge [
      { 
        name = "${cfg.username}";
        shell = pkgs.zsh;
        home = homeDir;
      }
    ];
  };
}