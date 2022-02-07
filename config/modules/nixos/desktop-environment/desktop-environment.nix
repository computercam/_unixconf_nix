{ config, lib, pkgs, options, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      xorg.xkill
      xorg.xrandr
      bibata-cursors
      papirus-icon-theme
    ];

    services.xserver = {
      enable = true;
      dpi = 96;
      layout = "us";
    };
  };
}
