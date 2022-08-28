{ config, lib, pkgs, options, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
      gnomeExtensions.just-perfection
      gnomeExtensions.appindicator
      gnomeExtensions.gsconnect
      bibata-cursors
      papirus-icon-theme
      yaru-theme
    ];
  };
}
