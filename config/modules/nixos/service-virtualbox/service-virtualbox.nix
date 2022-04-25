{ config, lib, pkgs, options, ... }: {
  config = {
    environment.systemPackages = with pkgs; [ virtualbox ];
    users.users.main.extraGroups = [ "vboxusers" ];
    boot.kernelModules = [ "vboxdrv" ];
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;
  };
}