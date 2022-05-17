{ config, pkgs, ... }:

{
  imports = [
    ./modules.nix
  ];

  config = {
    programs.zsh.enable = true;
    environment.systemPath = [ "/run/current-system/sw/bin/" ];
    services.nix-daemon.enable = true;
    system.stateVersion = 4;
    nix.maxJobs = 10;
  };
}
