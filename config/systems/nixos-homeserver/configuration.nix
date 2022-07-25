{ config, pkgs, ... }:

let cfg = config.cfg;
in {
  imports = [ ./hardware-configuration.nix ./modules.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  cfg.os.unix = "linux";
  cfg.os.version = "22.05";
  hardware.enableRedistributableFirmware = true;
  nix.autoOptimiseStore = true;
  nix.maxJobs = 4;
  nixpkgs.config.allowUnfree = true;
  services.fstrim.enable = true;
  system.autoUpgrade.channel =
    "https://channels.nixos.org/nixos-${cfg.os.version}";
  system.stateVersion = cfg.os.version;
  programs.zsh.enable = true;
}
