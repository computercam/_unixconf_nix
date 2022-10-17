{ config, lib, pkgs, options, ... }: {
  config.homebrew.taps = [ "jakehilborn/jakehilborn" ];
  config.homebrew.brews = [ "displayplacer" ];
  config.homebrew.casks = [        
    "microsoft-teams"
    "slack"
  ];
}
