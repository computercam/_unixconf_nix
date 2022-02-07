{ config, lib, pkgs, options, ... }: {
  config.services.xrdp = {
    defaultWindowManager = "gnome-sell";
    enable = true;
    openFirewall = true;
  };
}
