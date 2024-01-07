{ config, lib, pkgs, options, ... }: {
  config = {
    fileSystems = {
      Storage = {
        device = "/dev/disk/by-label/STORAGE";
        fsType = "ext4";
        mountPoint = "/Volumes/Storage";
      };
    };
  };
}
