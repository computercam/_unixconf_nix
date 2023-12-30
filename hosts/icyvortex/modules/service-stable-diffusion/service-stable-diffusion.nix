{ config, lib, pkgs, options, ... }: 
let 
  download = (import ./download.nix) { pkgs = pkgs; };
in {
  config = {
    # systemd.services.docker-stable-diffusion-webui-download.preStart = '''';

    virtualisation.oci-containers.containers = {
      stable-diffusion-webui-download = {
        image = "stable-diffusion-webui-download:latest";
        imageFile = download;
        # ports = [];
        # volumes = [];
        # environment = {};
        extraOptions =
          [ "--network=${config.cfg.docker.networking.dockernet}" ];
      };
    };
    # networking.firewall.allowedTCPPorts = [];
  };
}
