{ config, pkgs, modulesPath, ...}:
{
   imports = [ 
      ./nomachine-overlay.nix
      ./nomachine-module.nix
   ];
   config = {
      # environment.systemPackages = with pkgs; [ nomachine ];
      users.users.main.extraGroups = [ "nx" ];
      users.users.gdm.extraGroups = [ "nx" ];
      services.nxserver = {
         enable = true;
         enableDebug = true;
         openFirewall = true;
      };
   };
}
