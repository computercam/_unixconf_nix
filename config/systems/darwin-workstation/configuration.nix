{ config, pkgs, ... }:

{
  imports = [
    ./modules.nix
  ];

  config = {
    services.nix-daemon.enable = true;
    system.stateVersion = 4;
    nix.maxJobs = 10;

    cfg.homebrew.casks = [        
      "appcleaner"
      "balenaetcher"
      "bitwig-studio"
      "blender"
      "brave-browser"
      "charles"
      "chromium"
      "cold-turkey-blocker"
      "darktable"
      "dash"
      "disk-drill"
      "docker"
      "element"
      "firefox"
      "geekbench"
      "gimp"
      "grandperspective"
      "handbrake"
      "inkscape"
      "iterm2"
      "karabiner-elements"
      "krita"
      "launchcontrol"
      "libreoffice"
      "little-snitch"
      "microsoft-teams"
      "moom"
      "musescore"
      "notion"
      "obs"
      "obsidian"
      "openvpn-connect"
      "protonmail-bridge"
      "protonvpn"
      "resilio-sync"
      "spotify"
      "slack"
      "the-unarchiver"
      "transmission"
      "visual-studio-code"
      "vlc"
      "wireshark"
      "xquartz"
      "zenmap"
    ];
  };
}
