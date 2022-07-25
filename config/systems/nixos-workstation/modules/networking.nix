{ config, lib, pkgs, options, ... }: {
  config = {
    cfg.networking = {
      hostname = "workstation";

      domain_name_servers = {
        primary = config.cfg.networking.static.default_gateway;
        secondary = config.cfg.networking.static.default_gateway;
      };

      static = {
        enable = true;
        default_gateway = "192.168.0.1";
        ip_address = "192.168.0.179";
        prefix_length = 24;
        interface = "enp3s0";
      };
    };
  };
}
