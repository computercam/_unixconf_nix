{ config, pkgs, ... }: {
  imports = [
    ../../modules/common/fonts/fonts.nix
    ../../modules/common/home/home.nix
    ../../modules/nixos/hardware-nvidia/hardware-nvidia.nix
    ../../modules/nixos/service-kvm/service-kvm.nix
    ../../modules/nixos/service-audio/service-audio.nix
    ../../modules/nixos/service-avahi/service-avahi.nix
    ../../modules/nixos/service-docker/service-docker.nix
    ../../modules/nixos/service-samba/service-samba.nix
    ../../modules/nixos/service-firewall/service-firewall.nix
    ../../modules/nixos/service-networking/service-networking.nix
    ../../modules/nixos/service-phone/service-phone.nix
    ../../modules/nixos/service-printing/service-printing.nix
    ../../modules/nixos/service-ssh/service-ssh.nix
    ../../modules/nixos/service-sudo/service-sudo.nix
    ./modules/hardware.nix
    # ./modules/service-stable-diffusion/service-stable-diffusion.nix     
    ./modules/software.nix
    ./modules/vscode-remote.nix
    # ./modules/desktop-environment.nix
    ./modules/filesystems.nix
    ./modules/samba.nix
  ];
}
