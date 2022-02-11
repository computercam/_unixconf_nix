{ config, pkgs, ... }:

{
  imports = [ ../../modules/common/home-manager/home-manager.nix ];

  config = {
    # cfg.networking.hostname = "darwin-desktop";
    environment.systemPackages =
    [ pkgs.vim
    ];
    services.nix-daemon.enable = true;
    programs.zsh.enable = true;  # default shell on catalina
    system.stateVersion = 4;
    nix.maxJobs = 10;
  };
}
