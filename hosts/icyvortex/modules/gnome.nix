{ config, lib, pkgs, options, ... }:
let
  monitorsXmlContent = builtins.readFile ./monitors.xml;
  monitorsConfig = pkgs.writeText "gdm_monitors.xml" monitorsXmlContent;
  nixosLogoPath = ../../../assets/logo.svg;
  backgroundImage = ../../../assets/mountains.jpg;
  gtkCss = ./gtk.css;
in {
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
      # papirus-icon-theme
      gnomeExtensions.dash-to-panel
      gnomeExtensions.arcmenu
      # yaru-theme
    ];

    systemd.tmpfiles.rules = [
      "L+ /run/gdm/.config/monitors.xml - - - - ${monitorsConfig}"
    ];

    home-manager.users."${config.cfg.user.name}" = {
      dconf.settings = {
        "org/gnome/desktop/background" = {
          color-shading-type = "solid";
          picture-options = "zoom";
          picture-uri = "file://${builtins.toString backgroundImage}";
          picture-uri-dark = "file://${builtins.toString backgroundImage}";
          primary-color = "#3a4ba0";
          secondary-color = "#2f302f";
        };

        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          clock-format = "12h";
          document-font-name = "Inter 11";
          enable-animations = true;
          font-antialiasing = "grayscale";
          font-hinting = "slight";
          font-name = "Inter 11";
          gtk-theme = "Adwaita-dark";
          icon-theme = "Papirus-Dark";
          monospace-font-name = "Fantasque Sans Mono";
        };

        "org/gnome/desktop/wm/preferences" = {
          button-layout = "appmenu:minimize,maximize,close";
          titlebar-font = "Inter Bold 11";
        };

        "org/gnome/shell" = {
          enabled-extensions = [
            "appindicatorsupport@rgcjonas.gmail.com"
            "arcmenu@arcmenu.com"
            "dash-to-panel@jderose9.github.com"
            "freon@UshakovVasilii_Github.yahoo.com"
            "gsconnect@andyholmes.github.io"
            "just-perfection-desktop@just-perfection"
            "user-theme@gnome-shell-extensions.gcampax.github.com"
          ];
        };

        "org/gnome/shell/extensions/freon" = {
          hot-sensors = [ "BYTE_TEMP0" "NVIDIA GeForce RTX 4090" ];
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

        "org/gnome/shell/extensions/arcmenu" = {
          custom-menu-button-icon = builtins.toString nixosLogoPath;
          custom-menu-button-icon-size = 26.0;
          enable-menu-hotkey = true;
          highlight-search-result-terms = true;
          menu-button-appearance = "Icon";
          menu-button-icon = "Custom_Icon";
          menu-item-icon-size = "Medium";
          menu-layout = "Runner";
          runner-font-size = 12;
          runner-menu-height = 345;
          runner-menu-width = 500;
          runner-position = "Top";
          runner-search-display-style = "List";
          runner-show-frequent-apps = true;
          search-provider-open-windows = true;
          search-provider-recent-files = true;
        };

        "org/gnome/shell/extensions/dash-to-panel" = {
          appicon-margin = 4;
          appicon-padding = 6;
          available-monitors = [ 1 0 ];
          dot-color-dominant = true;
          dot-position = "TOP";
          dot-size = 2;
          focus-highlight = true;
          focus-highlight-dominant = true;
          focus-highlight-opacity = 40;
          multi-monitors = false;
          panel-anchors = ''{"0":"MIDDLE","1":"MIDDLE"}'';
          panel-lengths = ''{"0":100,"1":100}'';
          panel-positions = ''{"0":"TOP","1":"TOP"}'';
          panel-sizes = ''{"0":38,"1":38}'';
          primary-monitor = 1;
          scroll-icon-action = "NOTHING";
          scroll-panel-action = "NOTHING";
          show-apps-icon-file = builtins.toString nixosLogoPath;
          stockgs-keep-dash = false;
          trans-bg-color = "#282828";
        };

        "org/gnome/tweaks" = { show-extensions-notice = false; };
      };

      # gtk = {
      #   enable = true;
      #   cursorTheme.package = pkgs.bibata-cursors;
      #   cursorTheme.name = "Bibata-Original-Classic";

      #   theme.package = pkgs.adw-gtk3;
      #   theme.name = "adw-gtk3";
      # };



      # # cd $(nix build nixpkgs\#yaru-theme --print-out-paths --no-link)

      # home.file.".config/gtk-4.0/gtk.css".source = builtins.toString gtkCss;
      # home.file.".config/gtk-4.0/gtk-dark.css".source = builtins.toString gtkCss;
    };

  };
}

