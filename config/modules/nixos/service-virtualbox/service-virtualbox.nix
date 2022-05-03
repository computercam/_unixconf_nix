{ config, lib, pkgs, options, ... }: {
  config = {
    users.users.main.extraGroups = [ "vboxusers" ];
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;
  };
}