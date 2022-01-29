{ config, lib, pkgs, ... }:

with pkgs.stdenv; 
with lib;

let
  cfg = config.cfg;
  homeDir = builtins.getEnv("HOME");
in
{
  options = {
    cfg.user = {
      name = mkOption {
        type = types.str;
        default = "cameron";
        description = "Username for the main user on the system";
      };

      fullname = mkOption {
        type = types.str;
        default = "Cameron Sanders";
        description = "Username for the main user on the system";
      };

      email = mkOption {
        type = types.str;
        default = "csanders@protonmail.com";
        description = "Email for the main user on the system";
      };

      dotfiles = mkOption {
        type = types.str;
        default = "git@github.com:computercam/_unixconf_dotfiles.git";
        description = "dotfiles repo for the main user on the system";
      }; 
    };
  };

  config = {
    nix.allowedUsers = [ cfg.user.name ];

    environment.systemPackages = with pkgs; [ vim ];

    environment.variables = { 
      TERMINAL = "kitty";
      EDITOR = "vim";
      VISUAL = "code";
    };

    users.users.main = mkMerge [
      { 
        initialPassword = cfg.user.name; 
        name = cfg.user.name;
        home = homeDir;
        uid = 1000;
        gid = 1000;
        group = cfg.user.name;
        createHome = true;
        extraGroups = [ "wheel" ];
        isNormalUser = true;
      }
    ];

    # home-manager.users.main = mkMerge [
    #   {
    #     programs.git = {
    #       enable = true;
    #       userName = cfg.user.name;
    #       userEmail = cfg.useremail;
    #     };
    #   }
    # ];
  };
}