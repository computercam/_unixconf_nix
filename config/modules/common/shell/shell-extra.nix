{ config, lib, pkgs, options, ... }: {
  config.environment.systemPackages = with pkgs; [
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

