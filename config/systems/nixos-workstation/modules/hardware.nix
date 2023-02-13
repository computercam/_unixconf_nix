{ config, lib, pkgs, options, ... }: {
  config = {
    environment.systemPackages = with pkgs; [ lm_sensors ];
    hardware.cpu.intel.updateMicrocode = true;
    hardware.enableRedistributableFirmware = true;
    powerManagement.cpuFreqGovernor = "performance";

    # https://nixos.wiki/wiki/AMD_GPU
    
    # boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelModules = [ 
      # GPU
      "amdgpu" 
      # # hypervisor
      # "kvm-intel"
      # Sensors
      "nct6775"
      # RGB
      "i2c-dev"
      "i2c-i801"
    ];

    # oepnrgb 
    hardware.i2c.enable = true;
    services.hardware.openrgb.enable = true;
    services.hardware.openrgb.motherboard = "intel";


    services.xserver.videoDrivers = [ "amdgpu" ];

    hardware.video.hidpi.enable = true;
    services.xserver.dpi = lib.mkForce 180;
    
    hardware.opengl = {
      extraPackages = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
        amdvlk
      ];
      
      driSupport = true;
      driSupport32Bit = true;
    };
  };
}
