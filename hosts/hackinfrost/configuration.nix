{ config, pkgs, ... }: {
  imports = [ ./modules.nix ];
  cfg.os.version = "22.11";
  programs.zsh.enable = true;
  environment.systemPath = [ "/run/current-system/sw/bin/" ];
  services.nix-daemon.enable = true;
  nix.settings.max-jobs = 16;
  nixpkgs.hostPlatform = "x86_64-darwin";
}
