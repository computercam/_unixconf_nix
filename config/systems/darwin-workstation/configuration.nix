{ config, pkgs, ... }:

{
  imports = [
    ./modules.nix
  ];

  config = {
    cfg.os.version = "22.11";
    programs.zsh.enable = true;
    environment.systemPath = [ "/run/current-system/sw/bin/" ];
    services.nix-daemon.enable = true;
    nix.maxJobs = 10;
  };
}
