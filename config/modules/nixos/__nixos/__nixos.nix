{ config, lib, pkgs, options, ... }:

with lib;

{
  config = {
    boot.cleanTmpDir = true;
    boot.tmpOnTmpfs = true;
    security.allowUserNamespaces = true;
    system.autoUpgrade.enable = true;
    users.mutableUsers = true;
  };
}
