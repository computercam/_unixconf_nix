{ config, lib, pkgs, options, ... }: {
  config = {
    docker-containers = {
      resiliosync = {
        image = "linuxserver/resilio-sync";
        ports = [ "8888:8888" "55555:55555" ];
        volumes = [
          "/Volumes/Server/docker/resiliosync/config:/config"
          "/Volumes/Server/docker/resiliosync/downloads:/downloads"
          "/Volumes:/sync"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Chicago";
        };
        restart = "unless-stopped";
      };
  };

  networking.firewall.allowedTCPPorts = [
    8888
    55555
  ];
}
