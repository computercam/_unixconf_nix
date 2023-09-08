{ config, pkgs, ... }: {
  imports = [
    ../../modules/common/fonts/fonts.nix
    ../../modules/common/home/home.nix
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
