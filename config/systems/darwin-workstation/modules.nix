{ config, pkgs, ... }: {
  imports = [
    ../../global/global.nix
    ../../modules/common/home-manager/home-manager.nix
    ../../modules/common/shell/shell.nix
    ../../modules/common/user-main/user-main.nix
    ../../modules/common/utils/utils.nix
    ../../modules/darwin/__darwin/__darwin.nix
    ../../modules/darwin/application-homebrew/application-homebrew.nix
  ];
}
