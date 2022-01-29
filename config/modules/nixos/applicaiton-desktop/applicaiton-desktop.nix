{ config, lib, pkgs, options, ... }:
{ config.environment.systemPackages = with pkgs; [
  blender
  brave
  charles3
  chromium
  discord
  element-desktop
  etcher
  filezilla
  firefox
  gimp-with-plugins
  handbrake
  inkscape
  kitty
  libreoffice
  musescore
  obs-studio
  obsidian
  protonmail-bridge
  remmina
  screenkey
  spotify
  vscode
  wireshark
  woeusb
  xmind
  zeal
]; }
