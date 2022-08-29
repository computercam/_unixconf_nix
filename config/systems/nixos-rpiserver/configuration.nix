{ config, pkgs, lib, ... }:

let cfg = config.cfg;
in {
  imports = [ ./hardware-configuration.nix ./modules.nix ];

  cfg.os.unix = "linux";
  cfg.os.version = "22.05";
  cfg.os.arch = "aarch64";
  nix.autoOptimiseStore = true;
  nixpkgs.config.allowUnfree = true;
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-${cfg.os.version}";
  system.stateVersion = cfg.os.version;

  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 30d";
  boot.cleanTmpDir = true;

  services.openssh.permitRootLogin = lib.mkForce "yes";
  programs.zsh.enable = true;
}