{ config, lib, pkgs, options, ... }: {
  config.users = {
    groups = { rae = { }; };
    users = {
      rae = {
        group = "rae";
        isNormalUser = true;
        createHome = false;
      };
    };
  };
}
