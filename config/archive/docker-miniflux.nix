{ config, lib, pkgs, options, ... }: {
  config = {
    virtualisation.oci-containers.containers = {
      miniflux = {
        image = "miniflux/miniflux:latest";
        ports = [ 
          "${config.cfg.networking.static.ip_address}:8082:8080" 
        ];
        environment = {
          PUID = "1000";
          PGID = "992";
          TZ = "America/Chicago";

          DATABASE_URL= "postgres://miniflux:2kakFGKUWtTltLs@miniflux-db/miniflux?sslmode=disable";
          RUN_MIGRATIONS= "1";
          CREATE_ADMIN= "1";
          ADMIN_USERNAME= "admin";
          ADMIN_PASSWORD= "2kakFGKUWtTltLs";
        };
        extraOptions = [ 
          "--network=${config.cfg.docker.networking.dockernet}" 
        ];
        dependsOn = [
          "miniflux-db"
        ];
      };

      miniflux-db = {
        image = "postgres:latest";
        environment = {
          PUID = "1000";
          PGID = "992";
          TZ = "America/Chicago";

          POSTGRES_USER= "miniflux";
          POSTGRES_PASSWORD= "2kakFGKUWtTltLs";
        };
        volumes = [
          "/Volumes/Server/docker/miniflux/db:/var/lib/postgresql/data"
        ];
        extraOptions = [ 
          "--network=${config.cfg.docker.networking.dockernet}" 
        ];
      };
    };

    # networking.firewall.allowedTCPPorts = [ 8080 ];
  };
}