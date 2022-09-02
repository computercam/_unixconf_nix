{ config, pkgs, lib, ... }:
{
  boot.loader.grub.enable = false;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelParams = [ 
    "console=tty1"
    "cma=256M" 
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  hardware.enableRedistributableFirmware = true;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
  
  swapDevices = [ { device = "/swapfile"; size = 8192; } ];
}
