{ config, pkgs, lib, ... }:

let cfg = config.cfg;
in {
  imports = [ 
    "${fetchTarball "https://github.com/NixOS/nixos-hardware/archive/51e4bdf379659e4f80afaa81deea821c48977058.tar.gz" }/raspberry-pi/4"
    ./hardware-configuration.nix 
    ./modules.nix
  ];

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

  programs.zsh.enable = true;
}
