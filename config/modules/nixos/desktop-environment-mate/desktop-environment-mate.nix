{ config, lib, pkgs, options, ... }: {
  imports = [ ./modules.nix ];

  config = {
    programs.dconf.enable = true;
    services.gnome.gnome-keyring.enable = true;
    services.xserver.desktopManager.mate.enable = true;
  };
}
