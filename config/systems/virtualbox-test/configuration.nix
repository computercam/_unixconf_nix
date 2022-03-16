{ config, lib, pkgs, ... }:
with lib;
let cfg = config.cfg;
in {
  imports = [
    <nixpkgs/nixos/modules/installer/virtualbox-demo.nix>
    ../../global/global.nix
    ../../modules/common/shell/shell.nix
    ../../modules/common/user-main/user-main.nix
    ../../modules/common/fonts/fonts.nix
    ../../modules/common/utils/utils.nix
    ../../modules/nixos/__nixos/__nixos.nix
    ../../modules/nixos/service-networking/service-networking.nix
    ../../modules/nixos/desktop-environment-gnome/desktop-environment-gnome.nix
    ../../modules/nixos/desktop-environment/desktop-environment.nix
    ../../modules/nixos/service-avahi/service-avahi.nix
    ../../modules/nixos/service-cron/service-cron.nix
    ../../modules/nixos/service-docker/service-docker.nix
    ../../modules/nixos/service-firewall/service-firewall.nix
    ../../modules/nixos/service-samba/service-samba.nix
    ../../modules/nixos/service-ssh/service-ssh.nix
    ../../modules/nixos/service-sudo/service-sudo.nix
    ./hardware-configuration.nix
  ];

  services.xserver.displayManager.sddm.enable = mkForce false;
  services.xserver.desktopManager.plasma5.enable = mkForce false;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  nix.maxJobs = 8;
  nixpkgs.config.allowUnfree = true;
  services.fstrim.enable = true;
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-21.11";
  system.stateVersion = "21.11";

  cfg.networking.hostname = "nixos-virtualbox";
  cfg.os.unix = "linux";
  cfg.os.version = "21.11";
}
