{ config, pkgs, ... }: {
  imports = [
    ../../global/global.nix
    
    ../../modules/common/user-main/user-main.nix

    ../../modules/nixos/__nixos/__nixos.nix
    ../../modules/nixos/service-avahi/service-avahi.nix
    ../../modules/nixos/service-docker/service-docker.nix
    ../../modules/nixos/service-firewall/service-firewall.nix
    ../../modules/nixos/service-networking/service-networking.nix
    ../../modules/nixos/service-ssh/service-ssh.nix
    ../../modules/nixos/service-sudo/service-sudo.nix

    ./modules/docker-adguard.nix
    ./modules/docker.nix
    ./modules/networking.nix
  ];
}
