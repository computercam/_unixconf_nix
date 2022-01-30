{ config, pkgs, ... }:

{
  imports = [
    ../../modules/darwin/__nixos/__nixos.nix
    ./hardware-configuration.nix
  ];

  system.stateVersion = "20.09";
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-unstable";

  cfg.networking.hostname = "nixos-desktop";
  nix.maxJobs = 16;
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.fstrim.enable = true; # ssd harddrives
  hardware.cpu.amd.updateMicrocode = true; # amd cpus

  hardware.enableRedistributableFirmware = true;
}
