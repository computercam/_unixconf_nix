{ config, lib, pkgs, options, ... }: {
  config.environment.systemPackages = with pkgs; [
    # baobab
    # blender
    # brave
    # celluloid
    # charles3
    # chromium
    # discord
    # element-desktop
    # etcher
    # evince
    # filezilla
    # foliate
    # gimp-with-plugins
    # gparted
    # gthumb
    # guake
    # handbrake
    # inkscape
    # kitty
    # libreoffice
    # musescore
    # obs-studio
    # obsidian
    # pitivi
    # protonmail-bridge
    # remmina
    # rhythmbox
    # screenkey
    # spotify
    # transmission-gtk
    # wireshark
    # zeal
    firefox-beta-bin
    vscode
  ];
}
