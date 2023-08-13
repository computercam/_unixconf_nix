{ config, pkgs, ... }:

let cfg = config.cfg;
in {
  imports = [ ./hardware-configuration.nix ./modules.nix ];
  
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";

  cfg.os.version = "22.05";

  hardware.enableRedistributableFirmware = true;

  nix.autoOptimiseStore = true;
  nix.maxJobs = 8;
  nixpkgs.config.allowUnfree = true;
  services.fstrim.enable = true;

  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-${cfg.os.version}";
  system.stateVersion = cfg.os.version;
  
  programs.zsh.enable = true;
  users.users.rae = {
    group = "rae";
    isNormalUser = true;
  };
  users.groups.rae.name = "rae";
}
