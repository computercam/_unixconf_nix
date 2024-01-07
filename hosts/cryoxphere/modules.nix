{ config, pkgs, ... }: {
  imports = [
    ../../modules/common/home/home.nix
    ../../modules/nixos/hardware-nvidia/hardware-nvidia.nix
    ../../modules/nixos/service-avahi/service-avahi.nix
    ../../modules/nixos/service-docker/service-docker.nix
    ../../modules/nixos/service-samba/service-samba.nix
    ../../modules/nixos/service-firewall/service-firewall.nix
    ../../modules/nixos/service-networking/service-networking.nix
    ../../modules/nixos/service-ssh/service-ssh.nix
    ../../modules/nixos/service-sudo/service-sudo.nix
    ./modules/hardware.nix
    # ./modules/service-stable-diffusion/service-stable-diffusion.nix     
    ./modules/vscode-remote.nix
    ./modules/filesystems.nix
    ./modules/samba.nix
  ];
}
