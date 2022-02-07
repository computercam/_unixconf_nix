{ config, pkgs, ... }: {
  imports = [
    ../../global/global.nix
    ../../modules/common/fonts/fonts.nix
    ../../modules/common/shell/shell.nix
    ../../modules/common/user-main/user-main.nix
    ../../modules/common/utils/utils.nix
    ../../modules/nixos/__nixos/__nixos.nix
    ../../modules/nixos/desktop-environment-gnome/desktop-environment-gnome.nix
    ../../modules/nixos/desktop-environment/desktop-environment.nix
    ../../modules/nixos/service-avahi/service-avahi.nix
    ../../modules/nixos/service-cron/service-cron.nix
    ../../modules/nixos/service-docker/service-docker.nix
    ../../modules/nixos/service-firewall/service-firewall.nix
    ../../modules/nixos/service-networking/service-networking.nix
    ../../modules/nixos/service-samba/service-samba.nix
    ../../modules/nixos/service-ssh/service-ssh.nix
    ../../modules/nixos/service-sudo/service-sudo.nix
    ../../modules/nixos/service-virtualbox/service-virtualbox.nix
    ../../modules/nixos/service-xrdp/service-xrdp.nix
    ./modules.users.nix
    ./modules/cron.nix
    ./modules/docker.nix
    ./modules/samba.nix
  ];
}