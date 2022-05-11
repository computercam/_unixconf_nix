{ lib, pkgs, options, ... }:
with pkgs.stdenv;
with lib; {
  options.cfg.homebrew = {
    brews = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Homebrew Brew Packages";
    };

    casks = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Homebrew Cask Packages";
    };

  };
}
