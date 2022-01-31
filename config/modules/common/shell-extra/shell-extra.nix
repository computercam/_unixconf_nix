{ config, lib, pkgs, options, ... }: {
  config.environment.systemPackages = with pkgs; [
    cmatrix
    cowsay
    figlet
    glances
    htop
    jp2a
    lolcat
    neofetch
    pipes
    pywal
    ranger
    toilet
    w3m
  ];
}

