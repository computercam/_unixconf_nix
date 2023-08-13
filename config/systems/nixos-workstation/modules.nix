{ config, pkgs, ... }: {
  imports = [
    ../../global/global.nix
    
    # ../../modules/common/agenix/agenix.nix
    ../../modules/common/fonts/fonts.nix
    ../../modules/common/shell/shell.nix
    # ../../modules/common/home-manager/home-manager.nix
    ../../modules/common/user-main/user-main.nix
    ../../modules/common/user-main/user-main-shell.nix
    ../../modules/common/utils/utils.nix
    ../../modules/common/flakes/flakes.nix

    ../../modules/nixos/service-avahi/service-avahi.nix
    ../../modules/nixos/service-firewall/service-firewall.nix
    ../../modules/nixos/service-networking/service-networking.nix
    ../../modules/nixos/service-ssh/service-ssh.nix
    ../../modules/nixos/service-sudo/service-sudo.nix
    ../../modules/nixos/service-docker/service-docker.nix
    ../../modules/nixos/service-phone/service-phone.nix
    ../../modules/nixos/service-printing/service-printing.nix

    ./modules/desktop-environment.nix
    ./modules/software.nix
    ./modules/hardware.nix
    ./modules/graphics.nix
    # ./modules/work.nix
  ];
}