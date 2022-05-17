{ config, lib, pkgs, options, ... }: {
  imports = [ 
    ./modules.nix 
    ./options.nix
  ];
  
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

