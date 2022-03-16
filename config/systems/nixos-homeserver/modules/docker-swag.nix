{ config, lib, pkgs, options, ... }: {
  config = {
    virtualisation.oci-containers.containers = {
      swag = {
        image = "linuxserver/swag";
        ports = [ "443:443" ];
        volumes = [ "/Volumes/Server/docker/swag/config:/config" ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Chicago";
          URL = "cameron.computer";
          SUBDOMAINS = "wildcard";
          VALIDATION = "dns";
          DNSPLUGIN = "cloudflare";
          EMAIL = "csanders@protonmail.com";
        };
      };
    };

    networking.firewall.allowedTCPPorts = [ 443 ];
  };
}
