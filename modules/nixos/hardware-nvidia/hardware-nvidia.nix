{ config, lib, pkgs, options, ... }: 
let 
  nvidiaPackage = config.boot.kernelPackages.nvidiaPackages.stable;
  nvidiaX11 = config.boot.kernelPackages.nvidia_x11;
  cudatoolkit = pkgs.cudatoolkit;
in {
  config = {
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    environment.systemPackages = with pkgs; [ cudatoolkit ];
    environment.variables.CUDA_PATH = cudatoolkit;
    environment.variables.LD_LIBRARY_PATH = "${nvidiaX11}/lib";

    systemd.services.nvidia-control-devices = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.ExecStart = "${nvidiaX11.bin}/bin/nvidia-smi";
    };

    virtualisation.docker.enableNvidia = true;
    systemd.enableUnifiedCgroupHierarchy = false;

    hardware.nvidia = {
      nvidiaSettings = true;
      package = nvidiaPackage;
    };

     nixpkgs.config.allowUnfree = true;
  };
}
