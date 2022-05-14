{ config, pkgs, ... }: {
  imports = [
    ../../global/global.nix
    ../../modules/common/dotfiles/dotfiles.nix
    ../../modules/common/fonts/fonts.nix
    ../../modules/common/home-manager/home-manager.nix
    ../../modules/common/shell/shell.nix
    ../../modules/common/user-main/user-main.nix
    ../../modules/common/utils/utils.nix
    ../../modules/darwin/__darwin/__darwin.nix
    ../../modules/darwin/application-desktop/application-desktop.nix
    ../../modules/darwin/service-yabai/service-yabai.nix
  ];
}