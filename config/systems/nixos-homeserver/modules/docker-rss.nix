{ config, lib, pkgs, options, ... }: {
  config = {
    virtualisation.oci-containers.containers = {
      rsshub = {
        image = "diygod/rsshub:chromium-bundled";
        ports = [ 
          "${config.cfg.networking.static.ip_address}:1200:1200" 
        ];
        environment = {
          NODE_ENV = "production";
          CACHE_TYPE = "redis";
          REDIS_URL = "redis://rsshub-redis:6379";
        };
        extraOptions = [ 
          "--network=${config.cfg.docker.networking.dockernet}"
        ];
      };

      rsshub-redis = {
        image = "redis:alpine";
        volumes = [
          "/Volumes/Server/docker/rss/rsshub:/data"
        ];
        extraOptions = [ 
          "--network=${config.cfg.docker.networking.dockernet}"
        ];
      };

      freshrss = {
        image = "lscr.io/linuxserver/freshrss:latest";
        # ports = [ 
        #   "${config.cfg.networking.static.ip_address}:80:80" 
        # ];
        volumes = [ "/Volumes/Server/docker/rss/freshrss:/config" ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Chicago";
        };
        extraOptions = [ 
          "--network=${config.cfg.docker.networking.dockernet}" 
          "--label=swag=enable" 
        ];
      };
    };

    # networking.firewall.allowedTCPPorts = [ 8080 ];
  };
}