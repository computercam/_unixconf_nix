{ config, pkgs, ... }:

let cfg = config.cfg;
in {
  imports = [ ./hardware-configuration.nix ./modules.nix ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  cfg.networking.hostname = "workstation";
  cfg.os.unix = "linux";
  cfg.os.version = "22.11";

  nix.settings.auto-optimise-store = true;
  nix.settings.max-jobs = 16;
  nixpkgs.config.allowUnfree = true;
  services.fstrim.enable = true;

  system.stateVersion = cfg.os.version;
  
  programs.zsh.enable = true;
}
