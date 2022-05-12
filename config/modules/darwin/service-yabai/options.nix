{ lib, pkgs, options, ... }:
with pkgs.stdenv;
with lib; {
  imports = [ ../../common/user-main/options.nix ];
  
  options.cfg.yabai = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable the yabai window manager.";
    };
  };
}
