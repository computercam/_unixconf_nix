{ config, pkgs, ... }:

let cfg = config.cfg;
in {
  imports = [ ./hardware-configuration.nix ./modules.nix ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  cfg.os.hostname = "icyvortex";
  cfg.os.version = "23.05";
  nix.settings.auto-optimise-store = true;
  nix.settings.max-jobs = 16;
  programs.zsh.enable = true;
  services.fstrim.enable = true;


}
