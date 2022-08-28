{ config, pkgs, lib, ... }:

let cfg = config.cfg;
in {
  imports = [ ./hardware-configuration.nix ./modules.nix ];

  # Preserve space by sacrificing documentation and history
  documentation.nixos.enable = false;
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 30d";
  boot.cleanTmpDir = true;

  services.openssh.permitRootLogin = lib.mkForce "yes";

  users.users.pi = {
    isNormalUser = true;
    home = "/home/pi";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  security.sudo.wheelNeedsPassword = false;

  cfg.os.unix = "linux";
  cfg.os.version = "22.05";
  cfg.os.arch = "aarch64";
  nix.autoOptimiseStore = true;
  nixpkgs.config.allowUnfree = true;
  system.autoUpgrade.channel =
    "https://channels.nixos.org/nixos-${cfg.os.version}";
  system.stateVersion = cfg.os.version;
  programs.zsh.enable = true;
}