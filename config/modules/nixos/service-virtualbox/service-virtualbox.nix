{ config, lib, pkgs, options, ... }:
{
  config = {
    users.users.main.extraGroups = [ "vboxusers" ];
    boot.kernelModules = [ "vboxdrv" ];
    virtualisation.virtualbox.host.enable = true;
  };
}
