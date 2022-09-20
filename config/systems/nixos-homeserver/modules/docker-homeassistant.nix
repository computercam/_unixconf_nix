{ config, lib, pkgs, options, ... }: {
  config = {
    virtualisation.oci-containers.containers = {
      homeassistant = {
        image = "lscr.io/linuxserver/homeassistant:latest";
        ports = [
          "8123:8123" 
        ];
        volumes = [ "/Volumes/Server/docker/homeassistant/config:/config" ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Chicago";
        };
        extraOptions = [ 
          "--network=host"
          # "--label=swag=enable"
        ];
      };
    };

    networking.firewall.allowedTCPPorts = [ 8123 ];
  };
}
