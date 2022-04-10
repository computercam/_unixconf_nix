{ config, pkgs, ... }:

let cfg = config.cfg;
in {
  imports = [ ./hardware-configuration.nix ./modules.nix ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  cfg.os.unix = "linux";
  cfg.os.version = "21.11";
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  nix.autoOptimiseStore = true;
  nix.maxJobs = 16;
  nixpkgs.config.allowUnfree = true;
  services.fstrim.enable = true;
  system.autoUpgrade.channel =
    "https://channels.nixos.org/nixos-${cfg.os.version}";
  system.stateVersion = cfg.os.version;
}
