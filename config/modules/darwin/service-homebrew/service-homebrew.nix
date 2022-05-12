{ config, lib, pkgs, ... }: {
  config.homebrew = {
    enable = true;
    cleanup = "zap";
  };
}