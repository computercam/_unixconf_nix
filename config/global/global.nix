{ config, lib, pkgs, ... }:

let
  inherit (lib) optional flatten;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; })
    isLinux isDarwin;
in {
  imports = flatten [
    ./options.nix
    (optional (isLinux) ./nixos.nix)
    (optional (isDarwin) ./macos.nix)
  ];

  cfg.os.name = if isLinux then "nixos" 
    else if isDarwin then "darwin" 
    else "";
  environment.systemPackages = with pkgs; [ git nixfmt vim ];
  environment.variables.LANG = config.cfg.localization.lang;
  networking.hostName = config.cfg.os.hostname;
  nix.autoOptimiseStore = true;
  nixpkgs.config.allowUnfree = true;
  time.timeZone = config.cfg.localization.timezone;
}
