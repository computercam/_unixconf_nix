{ config, lib, pkgs, options, ... }:
with lib; {
  imports = [ ./modules.nix ];
  config.services.xserver.desktopManager.plasma5.enable = true;
}
