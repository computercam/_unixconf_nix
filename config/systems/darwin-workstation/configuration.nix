{ config, pkgs, ... }:

{
  imports = [
    ../../global/global.nix
    ../../modules/darwin/__darwin/__darwin.nix
    ../../modules/common/user-main/user-main.nix
    # ../../modules/common/home-manager/home-manager.nix
  ];

  config = {
    # cfg.networking.hostname = "darwin-desktop";
    environment.systemPackages = with pkgs; [ vim ];
    services.nix-daemon.enable = true;
    programs.zsh.enable = true;  # default shell on catalina
    system.stateVersion = 4;
    nix.maxJobs = 10;
  };
}
