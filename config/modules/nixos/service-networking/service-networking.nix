{ config, lib, pkgs, options, ... }:
with pkgs.stdenv;
with lib;
let cfg = config.cfg;
in {
  options.cfg.networking = {
    domain_name_servers = {
      primary = mkOption {
        type = types.str;
        default = "1.1.1.1";
        description = "Primary DNS Server";
      };

      secondary = mkOption {
        type = types.str;
        default = "9.9.9.9";
        description = "Secondary DNS Server";
      };
    };

    hostname = mkOption {
      type = types.str;
      default = cfg.os.family;
      description = "Primary DNS Server";
    };

    static = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable Static Networking";
      };

      default_gateway = mkOption {
        type = types.str;
        default = "192.168.0.1";
        description = "Static Networking Default Gateway";
      };

      ip_address = mkOption {
        type = types.str;
        default = "192.168.0.10";
        description = "Static Networking IP Address";
      };

      # subnet_mask = mkOption {
      #   type = types.str;
      #   default = "255.255.255.0";
      #   description = "Static Networking Subnet Mask";
      # };

      # interface = mkOption {
      #   type = types.str;
      #   default = "eth0";
      #   description = "Static Networking Network Interface";
      # };
    };
  };

  config.networking = mkMerge [
    { hostname = cfg.networking.hostname; }

    (mkIf (cfg.networking.static.enable == true) {
      dhcpcd = {
        enable = true;
        persistent = true;
        extraConfig = ''
          static ip_address=${cfg.networking.static.ip_address}/24      
          static routers=${cfg.networking.static.default_gateway}
          static domain_name_servers=${cfg.networking.domain_name_servers.primary} ${cfg.networking.domain_name_servers.secondary}
        '';
      };
    })

    (mkIf (cfg.networking.static.enable != true) {
      networkmanager = {
        enable = true;
        ethernet.macAddress = "stable";
        wifi.macAddress = "random";
        insertNameservers = [
          cfg.networking.domain_name_servers.primary
          cfg.networking.domain_name_servers.secondary
        ];
      };
    })
  ];
}
