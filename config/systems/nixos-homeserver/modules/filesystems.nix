{ config, lib, pkgs, options, ... }: {
  config.fileSystems = {
    Server = {
      device = "/dev/disk/by-label/SERVER";
      mountPoint = "/Volumes/Server";
      fsType = "btrfs";
    };

    Storage = {
      device = "/dev/disk/by-label/STORAGE";
      mountPoint = "/Volumes/Storage";
      fsType = "ext4";
    };

    Backup = {
      device = "/dev/disk/by-label/BACKUP";
      mountPoint = "/Volumes/Backup";
      fsType = "ext4";
    };
  };
}
