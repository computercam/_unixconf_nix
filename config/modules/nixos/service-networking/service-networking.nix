{ config, lib, pkgs, options, ... }:

{
  # options = {
  #   cfg.networking = {
  #     persistent = mkOption {
  #       type = types.bool;
  #       description = "whether to use persistent networking.";
  #     };
  #   };
  # };
  config = {
    networking = {
      hostname = cfg.systemname;

      networking = {
        # TODO: consider remove uneeded options here
        # TODO: consider making these values configurable
        # TODO: persistent netwokring vs managed
        # https://nixos.wiki/wiki/Networking

        # hostname = cfg.systemname;
        # networking.useDHCP = true;
        # networking.dhcpcd.persistent = true;

        # networking.dhcpcd.extraConfig = ''
        #   static ip_address=192.168.0.169/24      
        #   static routers=192.168.0.1
        #   static domain_name_servers=192.168.0.1 192.168.0.1
        # '';
      
        networkmanager = {
          enable = true;
          ethernet.macAddress = "stable";
          wifi.macAddress = "random";
        };
      };

    };
  };
}
