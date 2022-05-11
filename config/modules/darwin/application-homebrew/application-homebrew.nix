{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.cfg.homebrew;
in {
  imports = [ ./options.nix ];
  
  config = {
    homebrew = {
      enable = true;
      brews = cfg.brews;
      casks = cfg.casks;
      cleanup = "zap";
    };
  };
}