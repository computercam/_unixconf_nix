{ config, lib, pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [ pavucontrol ];
    users.users."${config.cfg.user.name}".extraGroups = [ "audio" ];
    sound.enable = true;

    hardware.bluetooth.enable = true;

    hardware.pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];

      extraConfig = ''
        load-module module-switch-on-connect
      '';

      daemon.config = {
        default-sample-format = "s24-32le";
        default-sample-rate = "44100";
      };
    };
  };
}
