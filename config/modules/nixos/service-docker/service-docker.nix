{ config, lib, pkgs, options, ... }:
with pkgs.stdenv;
with lib; {
  imports = [ ./options.nix ];

  config = {
    users.groups.docker = { };
    users.users."${config.cfg.user.name}".extraGroups = [ "docker" ];

    environment.systemPackages = with pkgs; [
      docker-compose
      docker-client
    ];

    virtualisation.docker = {
      enable = true;
      storageDriver = "overlay2";
      extraOptions = ''
        --bip="${config.cfg.docker.networking.bip}" --data-root="${config.cfg.docker.storage_root}" --dns="${config.cfg.docker.networking.dns.primary}" --dns="${config.cfg.docker.networking.dns.secondary}" --iptables=${config.cfg.docker.networking.iptables}'';
    };
  };
}
