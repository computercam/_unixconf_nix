{ config, lib, pkgs, options, ... }:
{ 
  config = {
    security.allowUserNamespaces = true;
    system.autoUpgrade.enable = true;

    users = {
      mutableUsers = true;
      defaultUserShell = pkgs.zsh;
    };
  };
}
