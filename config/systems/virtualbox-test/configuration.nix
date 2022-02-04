{ config, lib, pkgs, ... }:
with lib;
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
  ../../modules/nixos/desktop-environment/desktop-environment.nix
  ../../modules/nixos/desktop-environment-gnome/desktop-environment-gnome.nix
  ../../modules/nixos/applicaiton-desktop/applicaiton-desktop.nix
  ../../modules/nixos/applicaiton-desktop-gtk/applicaiton-desktop-gtk.nix
  ../../modules/nixos/service-audio/service-audio.nix
  ../../modules/nixos/service-audio-daw/service-audio-daw.nix
  ../../modules/nixos/service-sudo/service-sudo.nix
  ./hardware-configuration.nix ];

  services.xserver.displayManager.sddm.enable = mkForce false;
  services.xserver.desktopManager.plasma5.enable = mkForce false;
  # cfg.networking.hostname = "nixos-desktop";
  environment.systemPackages = with pkgs; [ vim vscode ];
  hardware.cpu.amd.updateMicrocode = true; # amd cpus
  hardware.enableRedistributableFirmware = true;
  nix.maxJobs = 8;
  nixpkgs.config.allowUnfree = true;
  services.fstrim.enable = true; # ssd harddrives
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-unstable";
  system.stateVersion = "21.11";
}
