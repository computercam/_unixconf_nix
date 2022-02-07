{ config, lib, pkgs, options, ... }: {
  config.users = {
    groups = { rae = { };  work = { }; };
    users = {
      rae = {
        group = "rae";
        isNormalUser = true;
        createHome = false;
      };
      work = {
        group = "work";
        isNormalUser = true;
        home = "/Volumes/Storage/Work";
        extraGroups = [ "docker" ];
      };
    };
  };
}
