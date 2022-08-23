{ config, lib, pkgs, options, ... }: {
  config = {
    virtualisation.oci-containers.containers = {
      resilio-sync = {
        image = "linuxserver/resilio-sync";
        ports = [ "8888:8888" "55555:55555" ];
        volumes = [
          "/Volumes/Server/docker/resiliosync/config:/config"
          "/Volumes/Server/docker/resiliosync/downloads:/downloads"
          "/Volumes/Storage:/sync"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Chicago";
        };
        extraOptions = [ "--network=${config.cfg.docker.networking.dockernet}" ];
      };
    };

    networking.firewall.allowedTCPPorts = [
      8888
      55555
    ];
  };
}
