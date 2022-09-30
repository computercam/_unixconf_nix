{ config, lib, pkgs, options, ... }: {
  # config.homebrew.brews = [ ];
  config.homebrew.casks = [        
    "microsoft-teams"
    "slack"
  ];
}
