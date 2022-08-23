{ config, lib, pkgs, options, ... }: {
  config.users = {
    groups = { 
      rae = { };
      # desmond = { }; 
    };
    users = {
      rae = {
        group = "rae";
        isNormalUser = true;
        home = "/Volumes/Storage/Rae";
      };

      # desmond = {
      #   group = "rae";
      #   isNormalUser = true;
      #   createHome = false;
      # };
    };
  };
}
