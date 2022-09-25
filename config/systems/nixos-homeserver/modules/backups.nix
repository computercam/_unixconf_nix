{ config, lib, pkgs, options, ... }: 
with lib;
let
  BorgRootPath = "/Volumes/Backup/BorgBackup";

  defaults = {
    encryption.mode = "none";
    compression = "auto,lzma";
    persistentTimer = true;
    startAt = "daily";
  };
  
  ServerLocal = mkMerge [ defaults {
    paths = "/Volumes/Server";
    repo = "${BorgRootPath}/Server";
    preHook = ''systemctl list-units --type=service --all \
      | grep docker- \
      | tr -s " " \
      | cut -d" " -f 2  \
      | xargs systemctl stop
    '';
    postHook = ''systemctl list-units --type=service --all \
      | grep docker- \
      | tr -s " " \
      | cut -d" " -f 2  \
      | xargs systemctl restart
    '';
    startAt = mkForce "*-*-* 02:00:00";
  }];

  RaeLocal = mkMerge [ defaults {
    paths = "/Volumes/Storage/Rae";
    repo = "${BorgRootPath}/Rae";
    startAt = mkForce "*-*-* 02:30:00";
  }];

  CameronLocal = mkMerge [ defaults {
    paths = "/Volumes/Storage/Cameron";
    repo = "${BorgRootPath}/Cameron";
    startAt = mkForce "*-*-* 03:00:00";
  }];

in {
  config.services.borgbackup = {
    jobs = {
      CameronLocal = CameronLocal;
      RaeLocal = RaeLocal;
      ServerLocal = ServerLocal;
    };
  };
}
