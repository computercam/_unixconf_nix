{ config, lib, pkgs, options, ... }: {
  imports = [ 
    ./modules.nix 
    ./options.nix
  ];
  
  config.home-manager.users."${config.cfg.user.name}".home.packages = with pkgs; 
   (if config.cfg.os.unix == "linux" then [
      cava
    ] else if config.cfg.os.unix == "darwin" then [
    ] else []) ++ [
      cmatrix 
      cowsay
      figlet
      lolcat
      pipes
      toilet
      pywal
      colorz
    ];
}

