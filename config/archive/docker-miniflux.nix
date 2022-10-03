{ config, lib, pkgs, options, ... }: {
  config = {
    age.secrets = {
      miniflux_password.file = ../../../../secrets/miniflux_admin_password.age;
    };

    systemd.services.docker-miniflux.preStart = '' 
      ENV_FILE="/Volumes/Server/docker/miniflux/.env.secret"

      ADMIN_PASSWORD=`cat ${config.age.secrets.miniflux_password.path}`
      POSTGRES_PASSWORD=`cat ${config.age.secrets.miniflux_password.path}`

      echo "ADMIN_PASSWORD=$ADMIN_PASSWORD" > $ENV_FILE
      echo "POSTGRES_PASSWORD=$POSTGRES_PASSWORD" > $ENV_FILE

      chmod 600 $ENV_FILE
      chown root.root $ENV_FILE
    '';


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
        };
        environmentFiles = [ /Volumes/Server/docker/miniflux/.env.secret ];
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
        };
        environmentFiles = [ /Volumes/Server/docker/miniflux/.env.secret ];
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