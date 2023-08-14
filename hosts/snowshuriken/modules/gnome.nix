{ config, lib, pkgs, options, ... }: 
let
  monitorsXmlContent = builtins.readFile ./monitors.xml;
  monitorsConfig = pkgs.writeText "gdm_monitors.xml" monitorsXmlContent;
in
{
  imports = [
    ../../../modules/nixos/desktop-environment-gnome/desktop-environment-gnome.nix
    ../../../modules/nixos/display-manager-gdm/display-manager-gdm.nix
  ];

  config = {
    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
      gnomeExtensions.just-perfection
      gnomeExtensions.appindicator
      gnomeExtensions.gsconnect
      gnomeExtensions.freon
      papirus-icon-theme
      gnomeExtensions.dash-to-panel
      gnomeExtensions.arcmenu
    ];

    systemd.tmpfiles.rules = [
      "f+ /run/gdm/.config/monitors.xml - gdm gdm - ${monitorsConfig}"
    ];

    home-manager.users."${config.cfg.user.name}".dconf.settings = {
      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        # picture-uri = "file:///nix/store/wfy1bsf97i8nsq7407mqz0ns39mdjxc5-simple-blue-2016-02-19/share/backgrounds/nixos/nix-wallpaper-simple-blue.png";
        # picture-uri-dark = "file:///nix/store/wrcvp07g9gfgw1c6d7ph0n0w5mifs5sb-simple-dark-gray-2016-02-19/share/backgrounds/nixos/nix-wallpaper-simple-dark-gray.png";
        primary-color = "#3a4ba0";
        secondary-color = "#2f302f";
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        document-font-name = "Inter 11";
        enable-animations = true;
        font-antialiasing = "grayscale";
        font-hinting = "slight";
        font-name = "Inter 11";
        gtk-theme = "Adwaita-dark";
        icon-theme = "Papirus-Dark";
        monospace-font-name = "FantasqueSansMono Nerd Font 10";
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
        titlebar-font = "Inter Bold 11";
      };

      "org/gnome/shell" = {
        enabled-extensions = [ 
          "appindicatorsupport@rgcjonas.gmail.com" 
          "freon@UshakovVasilii_Github.yahoo.com" 
          "gsconnect@andyholmes.github.io" 
          "just-perfection-desktop@just-perfection" 
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];
      };

      "org/gnome/shell/extensions/freon" = {
        hot-sensors = [ "BYTE_TEMP0" ];
      };

      "org/gnome/shell/extensions/just-perfection" = {
        accessibility-menu = false;
        activities-button = false;
        animation = 2;
        clock-menu-position = 1;
        clock-menu-position-offset = 6;
        dash-icon-size = 48;
        keyboard-layout = false;
        notification-banner-position = 2;
        panel = true;
        quick-settings = true;
        search = false;
        show-apps-button = false;
        startup-status = 0;
        theme = true;
        weather = false;
        workspace-wrap-around = true;
        world-clock = false;
      };

      "org/gnome/tweaks" = {
        show-extensions-notice = false;
      };
    };
  };
}






