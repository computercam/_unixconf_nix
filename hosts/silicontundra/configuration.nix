{ config, pkgs, ... }: {
  imports = [ ./modules.nix ];
  cfg.os.version = "23.05";
  nix.maxJobs = 10;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
