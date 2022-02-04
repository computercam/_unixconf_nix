{ config, lib, pkgs, options, ... }: {
  imports = [ ../desktop-environment/desktop-environment.nix ];

  config = {
    environment.systemPackages = with pkgs; [
      gnome.gnome-terminal
      gnome.gnome-tweaks
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.just-perfection
      gnomeExtensions.desktop-icons-neo
      gnomeExtensions.gsconnect
    ];

    programs.dconf.enable = true;
    services.gnome.gnome-keyring.enable = true;

    services.xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
