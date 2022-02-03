{ config, pkgs, lib, ... }: {
  config.environment.systemPackages = with pkgs; [ ffmpeg-full imagemagick ];
}
