{ config, lib, pkgs, options, ... }:
{ config.environment.systemPackages = with pkgs; [
    apfs-fuse
    ddrescue
    exfat
    ext4magic
    fuse-common
    hfsprogs
    mergerfs
    mergerfs-tools
    ntfs3g
  ];
}
