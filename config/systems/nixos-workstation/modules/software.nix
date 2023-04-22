{ config, lib, pkgs, options, ... }: {
  config.nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
  ];
  config.environment.systemPackages = with pkgs; [
    # baobab
    # blender
    # brave
    # celluloid
    # charles3
    # discord
    # element-desktop
    # evince
    # filezilla
    # foliate
    # guake
    # kitty
    # musescore
    # obs-studio
    # pitivi
    # screenkey
    # transmission-gtk
    # wireshark
    google-chrome-dev
    etcher
    firefox
    gimp-with-plugins
    gparted
    gthumb
    handbrake
    inkscape
    libreoffice
    obsidian
    protonmail-bridge
    spotify
    vscode
    zeal
  ];
}
