{ config, lib, pkgs, ... }:

with pkgs.stdenv;
with lib;

let cfg = config.cfg;
in {
  options.cfg.user = {
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

  config = {
    nix.allowedUsers = [ cfg.user.name ];

    environment.systemPackages = with pkgs; [ vim alacritty vscode ];

    environment.variables = {
      TERMINAL = "alacritty";
      EDITOR = "vim";
      VISUAL = "code";
    };

    users.users.main = {
      initialPassword = cfg.user.name;
      name = cfg.user.name;
      home = if isLinux then
        "/home/${cfg.user.name}"
      else if isDarwin then
        "/Users/${cfg.user.name}"
      else
        "/home/${cfg.user.name}";
      group = cfg.user.name;
      createHome = true;
      extraGroups = if isLinux then
        [ "wheel" ]
      else if isDarwin then
        [ "staff" ]
      else
        "/home/${cfg.user.name}";
      isNormalUser = true;
      shell = pkgs.zsh;
    };

    users.groups.main = { name = cfg.user.name; };

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
