{ config, lib, pkgs, options, ... }: {
  imports = [ ./modules.nix ];

  config = {
    environment.systemPackages = with pkgs; [
      gnome.gnome-terminal
      gnome.gnome-tweaks
    ];

    programs.dconf.enable = true;
    services.gnome.gnome-keyring.enable = true;
    # services.gnome.gnome-remote-desktop.enable = true;

    services.xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
