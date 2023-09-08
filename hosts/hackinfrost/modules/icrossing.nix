{ config, lib, pkgs, options, ... }:
with pkgs.stdenv;
with lib;
let 
  # dotfiles = import ./../../../utils/dotfiles.nix; 
  mavenjdk11 = pkgs.maven.override { jdk = pkgs.jdk11; };
in
{
  # nix.settings.allowed-users = [ "icrossing" ];
  users.users.icrossing.home = "/Users/icrossing"; 
  
  home-manager.users.icrossing = {
    home = {
      stateVersion = config.cfg.os.version;
      # file = (mkMerge (dotfiles ../../../modules/common/dotfiles/.dotfiles));

      packages = config
        .home-manager
        .users
        ."${config.cfg.user.name}"
        .home
        .packages ++ (with pkgs; [
          colima
          docker
          docker-compose
          nodejs-slim
          mavenjdk11
          jdk11
          slack
          teams
        ]);
    };
    
    programs = {
      git = {
        enable = true;
        userName = "Cameron Keathley";
        userEmail = "cameron.keathley@icrossing.com";
      };
      zsh = {
        enable = true;

        initExtra = config
          .home-manager
          .users
          ."${config.cfg.user.name}"
          .programs
          .zsh
          .initExtra + ''
            JAVA_HOME=${pkgs.jdk11.home}
          '';
      };
    };
  };
}
