{ config, lib, pkgs, options, ... }: {
  config = {
    # cfg.networking = {
      # hostname = "workstation";

      # static = {
        # enable = false;
        # default_gateway = "192.168.0.1";
        # ip_address = "192.168.0.69";
        # prefix_length = 24;
        # interface = "virbr0";
      # };

    # };

    # networking.bridges.virbr0.interfaces = [ "enp112s0" "enp0s31f6" ];
    # cfg.networking = {
    #   hostname = "nixos";

    #   domain_name_servers = {
    #     primary = config.cfg.networking.static.default_gateway;
    #     secondary = config.cfg.networking.static.default_gateway;
    #   };

    #   static = {
    #     enable = true;
    #     default_gateway = "192.168.0.1";
    #     ip_address = "192.168.0.69";
    #     prefix_length = 24;
    #     interface = "enp112s0";
    #   };
    # };
  };
}
