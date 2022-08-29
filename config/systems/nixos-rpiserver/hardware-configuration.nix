{ config, pkgs, lib, ... }:
{
  boot.loader.grub.enable = false;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ 
    "console=tty1"
    "cma=256M" 
  ];

  boot.loader.raspberryPi = {
    enable = true;
    version = 4;
    uboot.enable = true;
  };
  
  hardware.enableRedistributableFirmware = true;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };
  
  swapDevices = [ { device = "/swapfile"; size = 8192; } ];
}