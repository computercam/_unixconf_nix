{ config, lib, pkgs, ... }: {
  options.cfg.flakes = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Flakes";
    };
  };
}
