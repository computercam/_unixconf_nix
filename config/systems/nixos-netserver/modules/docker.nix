{ config, lib, pkgs, options, ... }: {
  config = {
    cfg.docker.storage_root = "/home/cameron/docker/docker_storage_root";
    cfg.docker.networking.iptables = "true";
  };
}
