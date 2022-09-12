{ config, lib, pkgs, options, ... }: {
  config = {
    virtualisation.oci-containers.containers = {
      nextcloud = {
        image = "lscr.io/linuxserver/nextcloud:latest";
        volumes = [
          "/Volumes/Storage:/Volumes/Storage"
          "/Volumes/Storage/Nextcloud:/data"
          "/Volumes/Server/docker/nextcloud/appdata:/config"
        ];
        environment = {
          PUID = "1000";
          PGID = "992";
          TZ = "America/Chicago";
        };
        extraOptions = [ 
          "--network=${config.cfg.docker.networking.dockernet}"
          "--label=swag=enable"
        ];
      };

      nextcloud_db = {
        image = "lscr.io/linuxserver/mariadb:latest";
        volumes = [
          "/Volumes/Server/docker/nextcloud/mariadb:/config"
        ];
        environment = {
          PUID = "1000";
          PGID = "992";
          TZ = "America/Chicago";
          MYSQL_ROOT_PASSWORD = "gyVgCabuuh20zyB";
          MYSQL_DATABASE = "nextcloud_db";
          MYSQL_USER = "nextcloud_db";
          MYSQL_PASSWORD = "2kakFGKUWtTltLs";
        };
        extraOptions = [ 
          "--network=${config.cfg.docker.networking.dockernet}"
        ];
      };
    };
  };
}