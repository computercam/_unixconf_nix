{ config, pkgs, lib, ...}:
with lib;
{
   imports = [ 
      ./nomachine-overlay.nix
      ./nomachine-module.nix
   ];

   config = mkMerge [({
      # environment.systemPackages = with pkgs; [ nomachine ];
      
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
   })];
}
