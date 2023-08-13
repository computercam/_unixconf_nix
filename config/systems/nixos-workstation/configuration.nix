{ config, pkgs, ... }:

let cfg = config.cfg;
in {
  imports = [ ./hardware-configuration.nix ./modules.nix ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  cfg.os.hostname = "nixos-workstation";
  cfg.os.version = "23.05";
  cfg.flakes.enable = true;
  nix.settings.auto-optimise-store = true;
  nix.settings.max-jobs = 16;
  services.fstrim.enable = true;
  programs.zsh.enable = true;
}
