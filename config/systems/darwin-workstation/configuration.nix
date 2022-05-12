{ config, pkgs, ... }:

{
  imports = [
    ./modules.nix
  ];

  config = {
    services.nix-daemon.enable = true;
    system.stateVersion = 4;
    nix.maxJobs = 10;
    # cfg.yabai.enable = true;
  };
}
