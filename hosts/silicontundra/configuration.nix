{ config, pkgs, ... }: {
  imports = [ ./modules.nix ];
  cfg.os.version = "23.05";
  programs.zsh.enable = true;
  environment.systemPath = [ "/run/current-system/sw/bin/" ];
  services.nix-daemon.enable = true;
  nix.maxJobs = 10;
}
