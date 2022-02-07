{ config, lib, pkgs, options, ... }: {
  config = {
    # docker-containers = {
    #   # portainer = {
    #   #   image = "portainer/portainer";
    #   #   ports = [ "8000:8000" "9000:9000" ];
    #   #   volumes = [
    #   #     "/var/run/docker.sock:/var/run/docker.sock"
    #   #     "portainer_data:/data"
    #   #   ];
    #   #   environment = {
    #   #     PUID = "1000";
    #   #     PGID = "1000";
    #   #     TZ = "America/Chicago";
    #   #   };
    #   # };

    #   # webserver = {
    #   #   image = "linuxserver/letsencrypt";
    #   #   ports = [ "80:80" "443:443" ];
    #   #   volumes = [ "letsencrypt_config:/config" ];
    #   #   environment = {
    #   #     PUID = "1000";
    #   #     PGID = "1000";
    #   #     TZ = "America/Chicago";
    #   #     URL = "cameron.computer";
    #   #     SUBDOMAINS = "wildcard";
    #   #     VALIDATION = "dns";
    #   #     DNSPLUGIN = "cloudflare";
    #   #     EMAIL = "csanders@protonmail.com";
    #   #   };
    #   # };
    # };
  };
}
