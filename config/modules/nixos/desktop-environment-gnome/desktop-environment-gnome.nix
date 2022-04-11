{ config, lib, pkgs, options, ... }: {
  imports = [ ./modules.nix ];

  config = {
    environment.systemPackages = with pkgs; [
      gnome.gnome-terminal
      gnome.gnome-tweaks
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.gsconnect
      gnomeExtensions.just-perfection
    ];

    programs.dconf.enable = true;
    services.gnome.gnome-keyring.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
  };
}
