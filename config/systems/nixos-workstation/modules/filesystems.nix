{ config, lib, pkgs, options, ... }: {
  config = {
    environment.systemPackages = with pkgs; [ btrfs-progs ntfs3g ];

    fileSystems = {     
      Storage = {
        device = "/dev/disk/by-uuid/a327e70c-2322-4c63-84fc-0fc128b95696";
        mountPoint = "/Volumes/Storage";
        fsType = "ext4";
      };

      Server = {
        device = "/dev/disk/by-uuid/76bc5abf-0185-41d0-8658-5038177def99";
        mountPoint = "/Volumes/Server";
        fsType = "btrfs";
        options = [ "compress=zstd" "subvol=Server" ];
      };
    };
  };
}
