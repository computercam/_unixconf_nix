{ config, lib, pkgs, options, ... }:
with pkgs.stdenv;
with lib;
let cfg = config.cfg;
in {
  imports = [ ../service-networking/service-networking.nix ];

  options.cfg.docker = {
    storage_root = mkOption {
      type = types.str;
      default = "/var/lib/docker";
      description = "Docker Storage Root";
    };

    networking = {
      bip = mkOption {
        type = types.str;
        default = "172.17.0.1/24";
        description = "Docker BIP";
      };

      dns = {
        primary = mkOption {
          type = types.str;
          default = cfg.networking.domain_name_servers.primary;
          description = "Docker Primary DNS";
        };

        secondary = mkOption {
          type = types.str;
          default = cfg.networking.domain_name_servers.secondary;
          description = "Docker Secondary DNS";
        };
      };

      iptables = mkOption {
        type = types.str;
        default = "false";
        description = "Docker IPTables Control";
      };
    };
  };

  config = {
    users.users.main.extraGroups = [ "docker" ];

    environment.systemPackages = with pkgs; [
      docker-compose
      docker-client
      docker
    ];

    virtualisation.docker = {
      enable = true;
      storageDriver = "overlay2";

      extraOptions = ''
        --bip="${cfg.docker.networking.bip}"
        --data-root="${cfg.docker.storage_root}"
        --dns="${cfg.docker.networking.dns.primary},${cfg.docker.networking.dns.secondary}"
        --iptables=${cfg.docker.networking.iptables}
      '';
    };
  };
}
