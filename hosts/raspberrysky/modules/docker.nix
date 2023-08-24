{ config, lib, pkgs, options, ... }: {
  config = {
    cfg.docker.storage_root = "/root/docker/docker_storage_root";
    cfg.docker.networking.iptables = "true";
  };
}
