{ config, lib, pkgs, options, ... }: {
  config = {
    boot.initrd.availableKernelModules = [ "amdgpu" ];

    # boot.blacklistedKernelModules = [
    #  "amdgpu"
    #  "radeon"
    # ];

  };
}
