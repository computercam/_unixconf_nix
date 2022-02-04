{ config, lib, pkgs, options, ... }:
with pkgs.stdenv;
with lib;
{
  imports = [ ./options.nix ];

  config.networking = mkMerge [
    ({ hostName = config.cfg.networking.hostname; })

    (mkIf (config.cfg.networking.static.enable == true) {
      dhcpcd = {
        enable = true;
        persistent = true;
        extraConfig = ''
          static ip_address=${config.cfg.networking.static.ip_address}/24      
          static routers=${config.cfg.networking.static.default_gateway}
          static domain_name_servers=${config.cfg.networking.domain_name_servers.primary} ${config.cfg.networking.domain_name_servers.secondary}
        '';
      };
    })

    (mkIf (config.cfg.networking.static.enable != true) {
      networkmanager = {
        enable = true;
        ethernet.macAddress = "stable";
        wifi.macAddress = "random";
        insertNameservers = [
          config.cfg.networking.domain_name_servers.primary
          config.cfg.networking.domain_name_servers.secondary
        ];
      };
    })
  ];
}
