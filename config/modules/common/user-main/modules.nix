{ config, lib, pkgs, options, ... }: {
  imports = [ 
    ../home-manager/home-manager.nix
    ../shell/shell.nix
  ];
}
