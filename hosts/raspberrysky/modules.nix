{ config, pkgs, ... }: {
  imports = [
    ../../modules/common/user-main/user-main.nix

    ../../modules/nixos/service-avahi/service-avahi.nix
    ../../modules/nixos/service-docker/service-docker.nix
    ../../modules/nixos/service-firewall/service-firewall.nix
    ../../modules/nixos/service-networking/service-networking.nix
    ../../modules/nixos/service-ssh/service-ssh.nix
    ../../modules/nixos/service-sudo/service-sudo.nix

    ./modules/desktop-environment.nix
    ./modules/docker.nix
    ./modules/docker-adguard.nix
    ./modules/docker-homeassistant.nix
    ./modules/networking.nix
  ];
}
