{ config, lib, pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      libimobiledevice
      ifuse
      gvfs
    ];
    
    services.gvfs.enable = true;
  };
}