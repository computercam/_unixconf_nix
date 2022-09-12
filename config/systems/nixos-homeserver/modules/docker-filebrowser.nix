# { config, lib, pkgs, options, ... }: {
#   config = {
#     virtualisation.oci-containers.containers = {
#       filebrowser = {
#         image = "filebrowser/filebrowser:s6";
#         ports = [ 
#           "${config.cfg.networking.static.ip_address}:8080:8080" 
#         ];
#         volumes = [
#           "/Volumes/Storage:/srv" 
#           "/Volumes/Server/docker/filebrowser/database/filebrowser.db:/database/filebrowser.db"
#           "/Volumes/Server/docker/filebrowser/config/settings.json:/config/settings.json"
#         ];
#         environment = {
#           PUID = "1000";
#           PGID = "992";
#           TZ = "America/Chicago";
#         };
#         extraOptions = [ 
#           "--network=${config.cfg.docker.networking.dockernet}"
#           "--label=swag=enable"
#         ];
#       };
#     };

#     # networking.firewall.allowedTCPPorts = [ 8080 ];
#   };
# }