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
    preHook = ''systemctl list-units --type=service --all | grep docker- | tr -s " " | cut -d" " -f 2  | xargs systemctl stop'';
    postHook = ''systemctl list-units --type=service --all | grep docker- | tr -s " " | cut -d" " -f 2  | xargs systemctl restart'';
    startAt = mkForce "*-*-* 03:00:00";
  }];

  RaeLocal = mkMerge [ defaults {
    paths = "/Volumes/Storage/Rae";
    repo = "${BorgRootPath}/Storage/Rae";
  }];

  # Spliting up larger directories for Cameron
  CameronDirs = (builtins.attrNames
    (lib.attrsets.filterAttrs (k: v: v == "directory")
      (builtins.readDir ("/Volumes/Storage/Cameron"))));

  CameronLocalJobs = (builtins.map 
    (dir: 
      let 
        dirName = lib.strings.concatStrings 
          (lib.strings.splitString " " dir);
      in {
        "Cameron${dirName}Local" = mkMerge [ defaults {
          paths = "/Volumes/Storage/Cameron/${dir}";
          repo = "${BorgRootPath}/Storage/Cameron/${dir}";
        }];
    }) CameronDirs);

in {
  config.services.borgbackup = {
    jobs = mkMerge ([
      { ServerLocal = ServerLocal; }
      { RaeLocal = RaeLocal; }
    ] ++ CameronLocalJobs);
  };
}
