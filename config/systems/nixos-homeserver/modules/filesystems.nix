{ config, lib, pkgs, options, ... }: {
  config = {
    environment.systemPackages = with pkgs; [ btrfs-progs mergerfs ];

    fileSystems = {
      Server = {
        device = "/dev/disk/by-uuid/cff42611-1f94-48d9-b92a-8a9168eebf8a";
        mountPoint = "/Volumes/Server";
        fsType = "btrfs";
        options = [ "subvol=Server" ];
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
