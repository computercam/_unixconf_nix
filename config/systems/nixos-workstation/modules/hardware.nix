{ config, lib, pkgs, options, ... }: {
  config = {
    environment.systemPackages = with pkgs; [ lm_sensors ];
    # https://nixos.wiki/wiki/AMD_GPU
    
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelModules = [ 
      # "amdgpu" 
      # "kvm-amd" 
      "nct6775" 
    ];
    services.xserver.videoDrivers = [ 
      # "amdgpu" 
    ];

    # hardware.video.hidpi.enable = true;
    # services.xserver.dpi = lib.mkForce 180;
    
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
