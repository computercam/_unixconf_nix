{ config, lib, pkgs, options, ... }: 
let 
  download = (import ./download.nix) { pkgs = pkgs; };
  automatic1111 = (import ./automatic1111.nix) { pkgs = pkgs; };
in {
  config = {
    # systemd.services.docker-stable-diffusion-webui-download.preStart = '''';

    virtualisation.oci-containers.containers = {
      stable-diffusion-webui-download = {
        image = "stable-diffusion-webui-download:latest";
        imageFile = download;
        volumes = [
          "/home/cameron/stable-diffusion-webui/data:/data"
        ];
        extraOptions =
          [ "--network=${config.cfg.docker.networking.dockernet}" ];
      };
      stable-diffusion-webui-automatic1111 = {
        image = "stable-diffusion-webui-automatic1111:latest";
        imageFile = automatic1111;
        volumes = [
          "/home/cameron/stable-diffusion-webui/data:/data"
        ];
        extraOptions =
          [ "--network=${config.cfg.docker.networking.dockernet}" ];
      };
    };
    # networking.firewall.allowedTCPPorts = [];
  };
}
