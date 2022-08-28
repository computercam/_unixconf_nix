{ config, lib, pkgs, options, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      gnomeExtensions.just-perfection
      gnome.gnome-tweaks
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.gsconnect
      bibata-cursors
    ];
  };
}