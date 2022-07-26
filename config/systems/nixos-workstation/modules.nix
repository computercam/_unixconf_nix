{ config, pkgs, ... }: {
  imports = [
    ../../global/global.nix
    
    ../../modules/common/fonts/fonts.nix
    ../../modules/common/shell/shell.nix
    ../../modules/common/home-manager/home-manager.nix
    ../../modules/common/user-main/user-main.nix
    ../../modules/common/user-main/user-main-shell.nix
    ../../modules/common/utils/utils.nix

    ../../modules/nixos/__nixos/__nixos.nix

    ../../modules/nixos/desktop-environment-gnome/desktop-environment-gnome.nix
    ../../modules/nixos/display-manager-lightdm/display-manager-lightdm.nix

    ../../modules/nixos/service-audio/service-audio.nix
    ../../modules/nixos/service-avahi/service-avahi.nix
    ../../modules/nixos/service-docker/service-docker.nix
    ../../modules/nixos/service-firewall/service-firewall.nix
    ../../modules/nixos/service-networking/service-networking.nix
    ../../modules/nixos/service-ssh/service-ssh.nix
    ../../modules/nixos/service-sudo/service-sudo.nix
    ../../modules/nixos/service-virtualbox/service-virtualbox.nix

    ./modules/filesystems.nix
    ./modules/development.nix
    ./modules/desktop-environment.nix
    ./modules/docker.nix
    ./modules/hardware.nix
    ./modules/networking.nix
    ./modules/vscode-remote.nix
    ./modules/work.nix
  ];
}
