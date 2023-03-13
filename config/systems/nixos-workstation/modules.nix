{ config, pkgs, ... }: {
  imports = [
    ../../global/global.nix
    
    ../../modules/common/agenix/agenix.nix
    ../../modules/common/shell/shell.nix
    ../../modules/common/home-manager/home-manager.nix
    ../../modules/common/user-main/user-main.nix
    ../../modules/common/user-main/user-main-shell.nix
    ../../modules/common/utils/utils.nix

    ../../modules/nixos/__nixos/__nixos.nix
    ../../modules/nixos/service-avahi/service-avahi.nix
    ../../modules/nixos/service-firewall/service-firewall.nix
    # ../../modules/nixos/service-networking/service-networking.nix
    ../../modules/nixos/service-ssh/service-ssh.nix
    ../../modules/nixos/service-sudo/service-sudo.nix
    ../../modules/nixos/service-kvm/service-kvm.nix
    ../../modules/nixos/software-gaming/software-gaming.nix

    ./modules/desktop-environment.nix
    ./modules/applications.nix
    ./modules/hardware.nix
    ./modules/osx-kvm/osx-kvm.nix
    # ./modules/networking.nix
  ];
}
