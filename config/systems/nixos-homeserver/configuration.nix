{ config, pkgs, ... }:

{
  imports = [
    ../../modules/darwin/__nixos/__nixos.nix
    ./hardware-configuration.nix
    ./modules/cron.nix
    ./modules/docker.nix
    ./modules/filesystems.nix
    ./modules/samba.nix
    ./modules/users.nix

  ];

  system.stateVersion = "20.09";
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-unstable";

  networking.hostName = "homeserver";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.fstrim.enable = true; # ssd harddrives
  hardware.cpu.intel.updateMicrocode = true; # intel cpus

  hardware.enableRedistributableFirmware = true;
}
