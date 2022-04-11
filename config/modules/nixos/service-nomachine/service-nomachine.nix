{ config, pkgs, lib, ...}:
with lib;
{
   imports = [ 
      ./nomachine-overlay.nix
      ./nomachine-module.nix
   ];

   config = mkMerge [({
      services.nxserver = {
         enable = true;
         enableDebug = true;
         openFirewall = true;
      }; 
   })
      
   (mkIf (config.services.xserver.displayManager.gdm.enable == true) {
      services.xserver.displayManager.gdm = {
         autoSuspend = mkForce false;
         wayland = mkForce false;
      };
   })
   
   (mkIf (config.services.xserver.xautolock.enable == true) {
      # environment.systemPackages = with pkgs; [ xscreensaver ];

      services.xserver.xautolock = {
         time = 1;
         locker = "${pkgs.xscreensaver}/bin/xscreensaver-command -lock";
      };
   })];
}
