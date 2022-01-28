{ config, lib, pkgs, ... }:

let
  Packages = with pkgs; [
    libimobiledevice
    ifuse
    gvfs
  ];
in 
{
  config = {
    services.gvfs.enable = true;
    environment.systemPackages = Packages;
  };
}