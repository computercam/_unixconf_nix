# https://nixos.wiki/wiki/AMD_GPU
{ config, lib, pkgs, options, ... }: {
  config = {
    boot.blacklistedKernelModules = [
      "amdgpu"
      "radeon"
    ];

    boot.kernelParams = [ 
      "iommu=pt" 
      "amd_iommu=on"
      "vfio-pci.ids=1002:67e3,1002:aae0" 
      "kvm.ignore_msrs=1" 
      "video=vesafb:off,efifb:off"
    ];
    # boot.extraModprobeConfig = ''
    #   options kvm_${cpuVendor} nested=1
    #   options kvm ignore_msrs=1
    # '';

  };
}
