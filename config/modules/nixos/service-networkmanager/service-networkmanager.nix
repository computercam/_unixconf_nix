{ config, lib, pkgs, options, ... }:
with lib;
let
  cfg = config.cfg;
in
{
  config = {
    networking.networkmanager = {
      enable = true;
      ethernet.macAddress = "stable";
      wifi.macAddress = "random";
    };

  };
}
