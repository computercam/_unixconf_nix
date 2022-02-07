{ config, lib, pkgs, options, ... }:

with lib;

{
  config = {
    boot.cleanTmpDir = true;
    boot.tmpOnTmpfs = true;
    environment.systemPackages = with pkgs; [ killall lshw lsof ];
    security.allowUserNamespaces = true;
    system.autoUpgrade.enable = true;
    users.mutableUsers = true;
  };
}
