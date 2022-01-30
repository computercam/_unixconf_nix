{ config, pkgs, ... }:

{
  imports = [
    ../../modules/darwin/__darwin/__darwin.nix
  ];

  config = {
    cfg.networking.hostname = "darwin-desktop";
    nix.maxJobs = 16;
  };
}
