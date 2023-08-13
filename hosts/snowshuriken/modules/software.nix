{ config, lib, pkgs, options, ... }: {
  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
  ];
  environment.systemPackages = with pkgs; [
    baobab
    # blender
    celluloid
    charles3
    discord
    # element-desktop
    # evince
    filezilla
    foliate
    guake
    kitty
    musescore
    obs-studio
    # pitivi
    screenkey
    transmission-gtk
    wireshark
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
