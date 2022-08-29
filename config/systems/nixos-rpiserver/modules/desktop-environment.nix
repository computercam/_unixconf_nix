{ config, lib, pkgs, options, ... }: {
  imports = [
    ../../../modules/nixos/desktop-environment-xfce/desktop-environment-xfce.nix
    ../../../modules/nixos/display-manager-lightdm/display-manager-lightdm.nix
  ];
  config = {
    services.xserver.videoDrivers = [ "fbdev" ];
  };
}
