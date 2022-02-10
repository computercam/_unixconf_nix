{ config, lib, pkgs, options, ... }:
with lib; {
  imports = [ ./modules.nix ];

  config = {
    services.xrdp.defaultWindowManager = mkForce "${pkgs.xfce.xfce4-session}/bin/xfce4-session";
    
    services.xserver = {
      displayManager.lightdm.enable = true;
      desktopManager.xfce.enable = true;
    };
  };
}
