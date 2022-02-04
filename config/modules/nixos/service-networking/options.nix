{ lib, pkgs, options, ... }:
with pkgs.stdenv;
with lib; {
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
      description = "System Hostname";
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

      subnet_mask = mkOption {
        type = types.str;
        default = "255.255.255.0";
        description = "Static Networking Subnet Mask";
      };

      interface = mkOption {
        type = types.str;
        default = "eth0";
        description = "Static Networking Network Interface";
      };
    };
  };
}
