{ config, lib, pkgs, options, ... }: {
  config = {
    environment.systemPackages = with pkgs; [ 
      btrfs-progs 
      mergerfs 
    ];

    fileSystems = {
      Backup = {
        device = "/dev/disk/by-label/BACKUP";
        mountPoint = "/Volumes/Backup";
        fsType = "ext4";
      };

      BulkStorage = {
        device = "/dev/disk/by-label/BULK_STORAGE";
        mountPoint = "/Volumes/BulkStorage";
        fsType = "ext4";
      };

      Server = {
        device = "/dev/disk/by-uuid/76bc5abf-0185-41d0-8658-5038177def99";
        mountPoint = "/Volumes/Server";
        fsType = "btrfs";
        options = [ "subvol=Server" ];
      };

      Storage = {
        device = "/dev/disk/by-label/STORAGE";
        mountPoint = "/Volumes/Storage";
        fsType = "ext4";
      };

      TimeMachine = {
        device = "/dev/disk/by-label/TIME_MACHINE";
        mountPoint = "/Volumes/TimeMachine";
        fsType = "ext4";
      };

      # Game1 = {
      #   device = "/dev/disk/by-label/GAME_1";
      #   mountPoint = "/Volumes/.GAME/1";
      #   fsType = "ext4";
      # };
      # Game2 = {
      #   device = "/dev/disk/by-label/GAME_2";
      #   mountPoint = "/Volumes/.GAME/2";
      #   fsType = "ext4";
      # };
      # Game3 = {
      #   device = "/dev/disk/by-label/GAME_3";
      #   mountPoint = "/Volumes/.GAME/3";
      #   fsType = "ext4";
      # };
      # Game4 = {
      #   device = "/dev/disk/by-label/GAME_4";
      #   mountPoint = "/Volumes/.GAME/4";
      #   fsType = "ext4";
      # };
      # Game = {
      #   device = "/Volumes/.GAME/*";
      #   mountPoint = "/Volumes/Game";
      #   fsType = "mergerfs";
      #   options = [ 
      #     "defaults" 
      #     "allow_other" 
      #     "use_ino" 
      #     "fsname=Game"
      #   ];
      # };
    };
  };
}
