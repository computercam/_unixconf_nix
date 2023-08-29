{ config, pkgs, ... }: {
  imports = [
    ../../modules/common/fonts/fonts.nix
    ../../modules/common/home/home.nix

    # ../../modules/macos/service-yabai/service-yabai.nix
    ../../modules/macos/application-desktop/application-desktop.nix
    
    ./modules/software.nix
    ./modules/icrossing.nix
  ];
}
