{ config, lib, pkgs, options, ... }: {
  config = {
    virtualisation.oci-containers.containers = {
      code-server = {
        image = "lscr.io/linuxserver/code-server:latest";
        ports = [ "${config.cfg.networking.static.ip_address}:8443:8443" ];
        volumes = [ "/Volumes/Server/docker/vscode/config:/config" ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Chicago";
          HASHED_PASSWORD = ''$argon2i$v=19$m=4096,t=3,p=1$lQaXIFqS9MamjYqUz2pj+w$Ydr14jlx7+ljWJVc561/JxO/EjhizDZyy/jRGoyTkS4''; #optional
          # SUDO_PASSWORD_HASH= #optional
          # PROXY_DOMAIN = "code-server.cameron.computer"; #optional
          # DEFAULT_WORKSPACE=/config/workspace #optional
        };
        extraOptions = [ 
          "--network=${config.cfg.docker.networking.dockernet}"
          "--label=swag=enable"
        ];
      };
    };
    # networking.firewall.allowedTCPPorts = [ 8443 ];
  };
}