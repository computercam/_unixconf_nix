{ config, lib, pkgs, options, ... }: {
  imports = [
    ../../../modules/nixos/desktop-environment-gnome/desktop-environment-gnome.nix
    ../../../modules/nixos/display-manager-gdm/display-manager-gdm.nix
  ];
  config = {
    services.xserver.videoDrivers = [ "fbdev" ];
  };
}
