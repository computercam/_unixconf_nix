{ config, lib, pkgs, options, ... }: {
  services.xserver.displayManager.gdm.autoSuspend = false;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.just-perfection
    gnomeExtensions.gsconnect
  ];
}
