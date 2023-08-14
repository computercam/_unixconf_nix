{ config, lib, pkgs, options, ... }: {
  imports = [
    ../../../modules/nixos/desktop-environment-plasma/desktop-environment-plasma.nix
    ../../../modules/nixos/display-manager-sddm/display-manager-sddm.nix
  ];

}






