{ config, lib, pkgs, options, ... }: 
with lib;
let
  BorgRootPath = "/Volumes/Backup/BorgBackup";

  defaults = {
    encryption.mode = "repokey";
    encryption.passCommand = "cat ${config.age.secrets.borgbackup.path}";
    compression = "auto,lzma";
    persistentTimer = true;
    appendFailedSuffix = false;
    exclude = [ "re:^.*\.sync/" ];
    environment.BORG_RSH = ''ssh -i ${builtins.toString (./../../../../_ + "/id_rsa.borgbackup")}'';
  };
  
  Server = mkMerge [ defaults {
    paths = "/Volumes/Server";
    repo = "${BorgRootPath}/Server";
    preHook = ''
      systemctl list-units --type=service --all \
        | grep docker- \
        | tr -s " " \
        | cut -d" " -f 2  \
        | xargs systemctl stop
    '';
    postHook = ''
      systemctl list-units --type=service --all \
        | grep docker- \
        | tr -s " " \
        | cut -d" " -f 2  \
        | xargs systemctl restart
    '';
    startAt = "*-*-* 01:00:00";
  }];

  ServerRemote = mkMerge [ Server {
    repo = mkForce "ssh://u320463@u320463.your-storagebox.de:23/./Backup/BorgBackup/Server";
    startAt = mkForce "*-*-* 01:30:00";
  }];

  Rae = mkMerge [ defaults {
    paths = "/Volumes/Storage/Rae";
    repo = "${BorgRootPath}/Rae";
    startAt = "*-*-* 02:00:00";
  }];

  RaeRemote = mkMerge [ Rae {
    repo = mkForce "ssh://u320463@u320463.your-storagebox.de:23/./Backup/BorgBackup/Rae";
    startAt = mkForce "*-*-* 02:30:00";
  }];

  Cameron = mkMerge [ defaults {
    paths = "/Volumes/Storage/Cameron";
    repo = "${BorgRootPath}/Cameron";
    startAt = "*-*-* 03:00:00";
  }];

  CameronRemote = mkMerge [ Cameron {
    repo = mkForce "ssh://u320463@u320463.your-storagebox.de:23/./Backup/BorgBackup/Cameron";
    startAt = mkForce "*-*-* 03:30:00";
  }];

in {
  config = {
    age.identityPaths = [ ../../../../_/id_rsa.borgbackup ];
    age.secrets.borgbackup.file = ../../../../secrets/borgbackup.age;

    services.borgbackup = {
      jobs = {
        Cameron = Cameron;
        CameronRemote = CameronRemote;
        Rae = Rae;
        RaeRemote = RaeRemote;
        Server = Server;
        ServerRemote = ServerRemote;
      };
    };
  };
}
