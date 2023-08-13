{ config, lib, pkgs, ... }: {
  imports = [ ./options.nix ];
  config = lib.mkIf (config.cfg.flakes.enable == true) {
    nix.package = pkgs.nixUnstable;
    nix.extraOptions = "experimental-features = nix-command flakes";
  };
}
