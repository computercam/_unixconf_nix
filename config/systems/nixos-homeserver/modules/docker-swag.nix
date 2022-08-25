{ config, lib, pkgs, options, ... }: {
  config = {
    virtualisation.oci-containers.containers = {
      swag = {
        image = "lscr.io/linuxserver/swag";
        ports = [ 
          "${config.cfg.networking.static.ip_address}:443:443" 
        ];
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
          DOCKER_MODS= "linuxserver/mods:swag-auto-proxy|linuxserver/mods:universal-docker|linuxserver/mods:universal-cloudflared";
          DOCKER_HOST = "dockerproxy";
          CF_ZONE_ID = "e181b1df3c7c326ed1a209d29965e4cc";
          CF_ACCOUNT_ID = "d7e1bc7351685e6a73a8fe78882136af";
          CF_API_TOKEN = "yWuAQ91nWhmRBZYhULlmKcwVivrFxGONMvkIdrKg";
          CF_TUNNEL_NAME = "cameron.computer";
          CF_TUNNEL_PASSWORD = "sVz#p7Z01$u1$w#Le#FT&oicvvTZ4d%D";
          FILE__CF_TUNNEL_CONFIG = "/config/tunnelconfig.yml";
        };
        extraOptions = [ 
          "--network=${config.cfg.docker.networking.dockernet}"
          "--add-host=cameron.computer:127.0.0.1"
          "--cap-add=NET_ADMIN"
        ];
      };

      dockerproxy = {
        image = "ghcr.io/tecnativa/docker-socket-proxy";
        volumes = [ "/var/run/docker.sock:/var/run/docker.sock:ro" ];
        environment = {
          CONTAINERS = "1";
          POST = "0"; 
        };
        extraOptions = [ 
          "--network=${config.cfg.docker.networking.dockernet}"
        ];
      };

      # authelia = {
      #   image = "ghcr.io/authelia/authelia:4.34.6";
      #   volumes = [ "/Volumes/Server/docker/swag/authelia:/config" ];
      #   environment = { TZ = "America/Chicago"; };
      #   extraOptions = [ "--user=1000:1000" ];
      # };
    };

    # networking.firewall.allowedTCPPorts = [ 443 ];
  };
}
