{ config, lib, pkgs, options, ... }: {
  config.services.samba.shares = {
    Storage = {
      path = "/Volumes/Storage";
       "valid users" = ''"cameron"'';
       "force user" = ''"cameron"'';
       "force group" = ''"cameron"'';
    };
  };
}
