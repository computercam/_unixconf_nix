{ config, pkgs, ... }: {
  imports = [
    ../../global/global.nix
    
    ../../modules/common/agenix/agenix.nix
    ../../modules/common/shell/shell.nix
    ../../modules/common/home-manager/home-manager.nix
    ../../modules/common/user-main/user-main.nix
    ../../modules/common/user-main/user-main-shell.nix
    ../../modules/common/fonts/fonts.nix
    ../../modules/common/utils/utils.nix

    ../../modules/nixos/__nixos/__nixos.nix
    ../../modules/nixos/service-avahi/service-avahi.nix
    ../../modules/nixos/service-cron/service-cron.nix
    ../../modules/nixos/service-docker/service-docker.nix
    ../../modules/nixos/service-firewall/service-firewall.nix
    ../../modules/nixos/service-networking/service-networking.nix
    ../../modules/nixos/service-samba/service-samba.nix
    ../../modules/nixos/service-ssh/service-ssh.nix
    ../../modules/nixos/service-sudo/service-sudo.nix

    ./modules/backups.nix
    # ./modules/desktop-environment.nix
    ./modules/development.nix
    ./modules/docker-gitea.nix
    ./modules/docker-nextcloud.nix
    ./modules/docker-penpot.nix
    ./modules/docker-resiliosync.nix
    ./modules/docker-swag.nix
    ./modules/docker-vscode.nix
    ./modules/docker.nix
    ./modules/filesystems.nix
    ./modules/networking.nix
    ./modules/samba.nix
    ./modules/vscode-remote.nix
    ./modules/work.nix
  ];
}
