{ config, lib, pkgs, options, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      # gnomeExtensions.just-perfection
      # papirus-icon-theme
      gnome.gnome-tweaks
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.gsconnect
      yaru-theme
      bibata-cursors
      # gparted
      # obsidian
    ];
  };
}