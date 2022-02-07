{ config, lib, pkgs, options, ... }: {
  config.fileSystems = {
    Server = {
      device = "/dev/disk/by-label/SERVER";
      mountPoint = "/Volumes/Server";
      fsType = "btrfs";
    };

    # fourTB2 = {
    #   device = "/dev/disk/by-label/4TBDISK2";
    #   mountPoint = "/srv/dev-disk-by-label-4TBDISK2";
    #   fsType = "ext4";
    #   options = fsOptionsExternal;
    # };

    # eightTB1 = {
    #   device = "/dev/disk/by-label/8TBDISK1";
    #   mountPoint = "/srv/dev-disk-by-label-8TBDISK1";
    #   fsType = "ext4";
    #   options = fsOptionsExternal;
    # };

    # eightTB2 = {
    #   device = "/dev/disk/by-label/8TBDISK2";
    #   mountPoint = "/srv/dev-disk-by-label-8TBDISK2";
    #   fsType = "ext4";
    #   options = fsOptionsExternal;
    # };

    # eightTB3 = {
    #   device = "/dev/disk/by-label/8TBDISK3";
    #   mountPoint = "/srv/dev-disk-by-label-8TBDISK3";
    #   fsType = "ext4";
    #   options = fsOptionsExternal;
    # };

    # eightTB4 = {
    #   device = "/dev/disk/by-label/8TBDISK4";
    #   mountPoint = "/srv/dev-disk-by-label-8TBDISK4";
    #   fsType = "ext4";
    #   options = fsOptionsExternal;
    # };

    # eightTB5 = {
    #   device = "/dev/disk/by-label/8TBDISK5";
    #   mountPoint = "/srv/dev-disk-by-label-8TBDISK5";
    #   fsType = "ext4";
    #   options = fsOptionsExternal;
    # };

    # eightTB6 = {
    #   device = "/dev/disk/by-label/8TBDISK6";
    #   mountPoint = "/srv/dev-disk-by-label-8TBDISK6";
    #   fsType = "ext4";
    #   options = fsOptionsExternal;
    # };

    # games = {
    #   device =
    #     "/srv/dev-disk-by-label-8TBDISK1:/srv/dev-disk-by-label-8TBDISK2:/srv/dev-disk-by-label-8TBDISK3:/srv/dev-disk-by-label-8TBDISK4";
    #   mountPoint = "/srv/sharedfolders/Games";
    #   fsType = "fuse.mergerfs";
    #   options = fsOptionsMergerfs;
    # };

    # cameron = {
    #   device =
    #     "/srv/dev-disk-by-label-4TBDISK1:/srv/dev-disk-by-label-4TBDISK2";
    #   mountPoint = "/srv/sharedfolders/Cameron";
    #   fsType = "fuse.mergerfs";
    #   options = fsOptionsMergerfs;
    # };

    # backup = {
    #   device =
    #     "/srv/dev-disk-by-label-8TBDISK5:/srv/dev-disk-by-label-8TBDISK6";
    #   mountPoint = "/srv/sharedfolders/Backup";
    #   fsType = "fuse.mergerfs";
    #   options = fsOptionsMergerfs;
    # };
  };
}
