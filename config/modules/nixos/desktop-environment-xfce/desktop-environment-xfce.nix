{ config, lib, pkgs, options, ... }:
with lib; {
  imports = [ ./modules.nix ];
  config.services.xserver.desktopManager.xfce.enable = true;
}
