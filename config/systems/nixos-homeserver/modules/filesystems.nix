{ config, lib, pkgs, options, ... }: {
  config = {
    environment.systemPackages = with pkgs; [ btrfs-progs ];

    fileSystems = {
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

      #Backup = {
      #  device = "/dev/disk/by-label/BACKUP";
      #  mountPoint = "/Volumes/Backup";
      #  fsType = "ext4";
      #};

      Nix = {
        device = "/dev/disk/by-label/NIX";
        mountPoint = "/nix";
        fsType = "ext4";
        neededForBoot = true;
        options = [ "noatime" ];
      };
    };
  };
}
