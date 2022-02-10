{ config, lib, pkgs, options, ... }:
with lib; {
  imports = [ ./modules.nix ];

  config = {
    services.xrdp.defaultWindowManager = mkForce "startplasma-x11";

    services.xserver = {
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
    };
  };
}
