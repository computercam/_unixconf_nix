{ config, lib, pkgs, options, ... }: {
  config = {
    # https://nixos.wiki/wiki/AMD_GPU
    
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "amdgpu" ];

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
