{ config, pkgs, ... }: {
  imports = [
    # ../../modules/common/dotfiles/dotfiles.nix 
    ../../modules/common/fonts/fonts.nix
    ../../modules/common/home/home.nix
    # ../../modules/darwin/service-yabai/service-yabai.nix
    ../../modules/darwin/application-desktop/application-desktop.nix
    ../../modules/darwin/system-defaults/system-defaults.nix
  ];
}
