{ config, lib, pkgs, options, ... }: {
  config = {
    boot.initrd.availableKernelModules = [ "amdgpu" ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelParams = [ "iommu=pt" "intel_iommu=on" ];

    # boot.blacklistedKernelModules = [
    #  "amdgpu"
    #  "radeon"
    # ];

    boot.extraModprobeConfig = ''
      options kvm_intel nested=1
      options kvm ignore_msrs=1
    '';

    environment.systemPackages = with pkgs; [
      qemu
      python3
      iproute2
    ];

    users.users."${config.cfg.user.name}".extraGroups = [ "libvirtd" ];
    virtualisation.libvirtd.enable = true;
  };
}
