{ config, lib, pkgs, options, ... }:
with lib;
let 
  PENPOT_ENV = {
    ## Should be set to the public domain where penpot is going to be served.
    ##
    ## NOTE: If you are going to serve it under different domain than
    ## 'localhost' without HTTPS, consider setting the
    ## `disable-secure-session-cookies' flag on the 'PENPOT_FLAGS'
    ## setting.

    PENPOT_PUBLIC_URI = "http://localhost:9001";
    PENPOT_TENANT = "pro";

    ## Feature flags.

    PENPOT_FLAGS = "enable-login disable-secure-session-cookies";

    ## Temporal workaround because of bad builtin default

    PENPOT_HTTP_SERVER_HOST = "0.0.0.0";

    ## Standard database connection parameters (only postgresql is supported):

    PENPOT_DATABASE_URI = "postgresql://penpot-postgres/penpot";
    PENPOT_DATABASE_USERNAME = "penpot";
    PENPOT_DATABASE_PASSWORD = "penpot";

    ## Redis is used for the websockets notifications.

    PENPOT_REDIS_URI = "redis://penpot-redis/0";

    ## By default, files uploaded by users are stored in local
    ## filesystem. But it can be configured to store in AWS S3.

    PENPOT_ASSETS_STORAGE_BACKEND= "assets-fs";
    PENPOT_STORAGE_ASSETS_FS_DIRECTORY = "/opt/data/assets";

    ## Telemetry. When enabled, a periodical process will send anonymous
    ## data about this instance. Telemetry data will enable us to learn on
    ## how the application is used, based on real scenarios. If you want
    ## to help us, please leave it enabled.

    PENPOT_TELEMETRY_ENABLED = "true";

    ## Email sending configuration. By default, emails are printed in the
    ## console, but for production usage is recommended to setup a real
    ## SMTP provider. Emails are used to confirm user registrations.

    PENPOT_SMTP_ENABLED = "false";
    PENPOT_SMTP_DEFAULT_FROM = "no-reply@example.com";
    PENPOT_SMTP_DEFAULT_REPLY_TO = "no-reply@example.com";
  }; 
  in 
{
  config = {
    virtualisation.oci-containers.containers = {
      penpot-frontend = {
        image = "penpotapp/frontend:latest";
        ports = [ 
          "${config.cfg.networking.static.ip_address}:9001:80" 
        ];
        volumes = [ "/Volumes/Server/docker/penpot/penpot_assets_data:/opt/data" ];
        environment = mkMerge [ PENPOT_ENV {
          PUID = "1000";
          PGID = "992";
          TZ = "America/Chicago";
        }];
        extraOptions = [ "--network=${config.cfg.docker.networking.dockernet}" ];
        dependsOn = [ 
          "penpot-backend" 
          "penpot-exporter" 
        ];
      };

      penpot-backend = {
        image = "penpotapp/backend:latest";
        volumes = [ "/Volumes/Server/docker/penpot/penpot_assets_data:/opt/data" ];
        environment = mkMerge [ PENPOT_ENV {
          PUID = "1000";
          PGID = "992";
          TZ = "America/Chicago";
        }];
        extraOptions = [ "--network=${config.cfg.docker.networking.dockernet}" ];
        dependsOn = [ 
          "penpot-postgres" 
          "penpot-redis" 
        ];
      };

      penpot-exporter = {
        image = "penpotapp/exporter:latest";
        environment = mkMerge [ PENPOT_ENV {
          PUID = "1000";
          PGID = "992";
          TZ = "America/Chicago";
          PENPOT_PUBLIC_URI = mkForce "http://penpot-frontend";
        }];
        extraOptions = [ "--network=${config.cfg.docker.networking.dockernet}" ];
      };

      penpot-postgres = {
        image = "postgres:13";
        environment = mkMerge [ PENPOT_ENV {
          PUID = "1000";
          PGID = "992";
          TZ = "America/Chicago";
          POSTGRES_INITDB_ARGS = "--data-checksums";
          POSTGRES_DB = "penpot";
          POSTGRES_USER = "penpot";
          POSTGRES_PASSWORD = "penpot";
        }];
        extraOptions = [ "--network=${config.cfg.docker.networking.dockernet}" ];
        volumes = [ "/Volumes/Server/docker/penpot/penpot_postgres_data:/var/lib/postgresql/data" ];
      };

      penpot-redis = {
        image = "redis:6";
        environment = {
          PUID = "1000";
          PGID = "992";
          TZ = "America/Chicago";
        };
        extraOptions = [ "--network=${config.cfg.docker.networking.dockernet}" ];
      };
    };

    # networking.firewall.allowedTCPPorts = [
    #   8888
    #   55555
    # ];
  };
}
