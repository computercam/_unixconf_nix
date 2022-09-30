{ config, lib, pkgs, options, ... }: {
  config.homebrew.brews = [ "displayplacer" ];
  config.homebrew.casks = [        
    "microsoft-teams"
    "slack"
  ];
}
