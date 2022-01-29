{ config, lib, pkgs, options, ... }:
{ config.environment.systemPackages = with pkgs; [
  baobab
  celluloid
  evince
  foliate
  gnome.file-roller
  gnome.gnome-calculator
  gnome.gnome-characters
  gnome.gnome-font-viewer
  gnome.gnome-logs
  gnome.gnome-screenshot
  gnome.gnome-system-monitor
  gnome.simple-scan
  gnome.gnome-terminal
  gparted
  gthumb
  guake
  pitivi
  rhythmbox
  transmission-gtk
]; }
