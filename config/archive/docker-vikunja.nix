# https://vikunja.io/docs/config-options/
{ config, lib, pkgs, options, ... }: {
  config = {
    virtualisation.oci-containers.containers = {
      vikunja-api = {
        image = "vikunja/api";
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Chicago";
          VIKUNJA_DATABASE_TYPE = "sqlite";
          VIKUNJA_DATABASE_PATH = "/storage/database.db";
          VIKUNJA_SERVICE_ENABLEREGISTRATION = "false";
        };
        volumes = [ 
          "/Volumes/Server/docker/vikunja/files:/app/vikunja/files" 
          "/Volumes/Server/docker/vikunja/storage:/storage"
        ];
        extraOptions = [ "--network=${config.cfg.docker.networking.dockernet}" ];
      };
      vikunja-frontend = {
        image = "vikunja/frontend";
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Chicago";
        };
        extraOptions = [ "--network=${config.cfg.docker.networking.dockernet}" ];
      };
      vikunja = {
        image = "nginx";
        ports = [ "${config.cfg.networking.static.ip_address}:8321:80" ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Chicago";
        };
        extraOptions = [ "--network=${config.cfg.docker.networking.dockernet}" ];
        volumes = [ "/Volumes/Server/docker/vikunja/nginx.conf:/etc/nginx/conf.d/default.conf:ro" ];
        dependsOn = [ 
          "vikunja-api"
          "vikunja-frontend"
        ];
      };
     
    };
    # networking.firewall.allowedTCPPorts = [ 8321 ];
  };
}
