{ config, lib, pkgs, options, ... }:

{
  config = {
    users.users."${cfg.username}".extraGroups = [ "docker" ];

    environment.systemPackages = with pkgs; [
      docker-compose_2
      docker-client
      docker
    ];

    virtualisation.docker = {
      enable = true;
      storageDriver = "overlay2";
      
      # TODO: consider remove uneeded options here
      # TODO: consider making these values configurable

      extraOptions = ''
        --bip="172.17.0.1/24"
        --data-root="/var/lib/docker"
        --dns="1.1.1.1,9.9.9.9"
        --iptables=true
      ''
    };

  };
}
