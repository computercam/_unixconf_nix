{ config, lib, pkgs, options, ... }: {
  config = {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.modesetting.enable = true;
    hardware.nvidia.prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
