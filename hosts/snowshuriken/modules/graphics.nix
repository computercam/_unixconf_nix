{ config, pkgs, ... }:

{
  boot.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [ "amdgpu.dc_feature_mask=0xF" ];
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [ amdvlk rocm-opencl-icd rocm-opencl-runtime ];
  services.xserver.videoDrivers = [ "amdgpu" ];     
}
