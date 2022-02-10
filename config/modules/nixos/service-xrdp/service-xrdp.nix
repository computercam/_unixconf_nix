{ config, lib, pkgs, options, ... }: {
  config.services.xrdp = {
    # defaultWindowManager = "xterm";
    enable = true;
    openFirewall = true;
  };
}