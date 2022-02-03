{ config, lib, pkgs, options, ... }: {
  config.environment.systemPackages = with pkgs; [
    apfs-fuse
    btrfs-progs
    ddrescue
    exfat
    ext4magic
    fuse-common
    hfsprogs
    ntfs3g
  ];
}
