{ config, lib, pkgs, options, ... }: {
  config = {
    environment.systemPackages = with pkgs; [ btrfs-progs ntfs3g ];

    fileSystems = {
      STORAGE = {
        device = "/dev/disk/by-label/STORAGE";
        mountPoint = "/tmp/STORAGE";
        fsType = "btrfs";
        options = [ "noauto" ];
      };

      Server = {
        device = "/dev/disk/by-label/STORAGE";
        mountPoint = "/Volumes/Server";
        fsType = "btrfs";
        options = [ "compress=zstd" "subvol=Server" ];
      };

      Storage = {
        device = "/dev/disk/by-label/STORAGE";
        mountPoint = "/Volumes/Storage";
        fsType = "btrfs";
        options = [ "compress=zstd" "subvol=Storage" ];
      };

      # Nix = {
      #   device = "/dev/disk/by-label/NIX";
      #   mountPoint = "/nix";
      #   fsType = "ext4";
      #   neededForBoot = true;
      #   options = [ "noatime" ];
      # };
    };
  };
}
