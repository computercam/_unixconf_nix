{ config, lib, pkgs, options, ... }: {
  config = {
    cfg.networking = {
      hostname = "homeserver";

      static = {
        enable = true;
        default_gateway = "192.168.0.1";
        ip_address = "192.168.0.169";
        prefix_length = 24;
        interface = "enp3s0";
      };
    };
  };
}
