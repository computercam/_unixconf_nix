{ config, pkgs, lib, ... }: {
  config.environment.systemPackages = with pkgs; [ youtube-dl ];
}
