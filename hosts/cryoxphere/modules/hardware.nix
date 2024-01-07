# https://nixos.wiki/wiki/AMD_GPU
{ config, lib, pkgs, options, ... }: {
  config = {
    # hardware.video.hidpi.enable = true;
    # services.xserver.dpi = lib.mkForce 180;
    services.xserver.videoDrivers = ["nvidia"];
    boot.kernelModules = [ "nct6775" "i2c-dev" "i2c-i801" ];
    # boot.kernelPackages = pkgs.linuxPackages_latest;
    environment.systemPackages = with pkgs; [ lm_sensors ];
    hardware.cpu.intel.updateMicrocode = true;
    hardware.enableRedistributableFirmware = true;
    hardware.i2c.enable = true;
    powerManagement.cpuFreqGovernor = "performance";
    services.hardware.openrgb.enable = true;
    services.hardware.openrgb.motherboard = "intel";
  };
}
