{ config, pkgs, ... }: {
  imports = [ ./modules.nix ];
  cfg.os.version = "23.05";
  nix.settings.max-jobs = 16;
  cfg.os.hostname = "hackinfrost";
  nixpkgs.hostPlatform = "x86_64-darwin";
}
