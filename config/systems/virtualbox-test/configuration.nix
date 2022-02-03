{ config, pkgs, ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/virtualbox-demo.nix>
  ../../global/global.nix
  ../../modules/common/shell/shell.nix
  ../../modules/common/user-main/user-main.nix
  ../../modules/common/utils/utils-downloads.nix
  ../../modules/common/utils/utils-filesystems.nix
  ../../modules/common/utils/utils-multimedia.nix
  ../../modules/common/utils/utils-networking.nix
  ../../modules/nixos/__nixos/__nixos.nix
  ./hardware-configuration.nix ];
  
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [ vim vscode ];
  system.stateVersion = "21.11";
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-unstable";

  # cfg.networking.hostname = "nixos-desktop";
  nix.maxJobs = 8;

  services.fstrim.enable = true; # ssd harddrives
  hardware.cpu.amd.updateMicrocode = true; # amd cpus

  hardware.enableRedistributableFirmware = true;
}
