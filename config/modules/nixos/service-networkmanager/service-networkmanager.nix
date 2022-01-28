{ config, lib, pkgs, options, ... }:

{
  config = {
    networking.networkmanager = {
      enable = true;
      ethernet.macAddress = "stable";
      wifi.macAddress = "random";
    };

  };
}
