{ config, lib, pkgs, options, ... }: {
  config.home-manager.users."${config.cfg.user.name}".home.packages = with pkgs; [
    cava
    cmatrix
    cowsay
    figlet
    jp2a
    lolcat
    pipes
    toilet
  ];
}

