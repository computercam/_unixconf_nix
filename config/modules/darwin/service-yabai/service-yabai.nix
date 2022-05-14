# https://github.com/koekeishiya/yabai
# https://github.com/koekeishiya/skhd

{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.cfg;

  homeDir = builtins.getEnv ("HOME");

in {
  imports = [ ./modules.nix ];

  config = {
    environment.systemPackages = with pkgs; [ nodejs ];
    
    homebrew = {
      taps = [ "koekeishiya/formulae" ];
      brews = [ "yabai" "skhd" ];
    };

    security.accessibilityPrograms =
      [ "/opt/homebrew/bin/yabai" "/opt/homebrew/bin/skhd" ];


    launchd.daemons.yabai-sa = {
      script = ''
        if [ ! $(/opt/homebrew/bin/yabai --check-sa) ]; then
          /opt/homebrew/bin/yabai --load-sa
          /opt/homebrew/bin/yabai --install-sa
        fi
      '';

      serviceConfig.RunAtLoad = true;
      serviceConfig.KeepAlive.SuccessfulExit = false;
    };

    launchd.user.agents.yabai = {
      serviceConfig.ProgramArguments =
        [ "/opt/homebrew/bin/yabai" "-c" "${homeDir}/.config/yabai/yabairc" ];
      serviceConfig.KeepAlive = true;
      serviceConfig.ProcessType = "Interactive";
    };

    launchd.user.agents.skhd = {
      serviceConfig.ProgramArguments =
        [ "/opt/homebrew/bin/skhd" "-c" "${homeDir}/.config/skhd/skhdrc" ];
      serviceConfig.KeepAlive = true;
      serviceConfig.ProcessType = "Interactive";
    };

    # TODO : Redo these at some point
    home-manager.users."${cfg.user.name}".home.file = mkMerge [
      {
        "yabai/yabairc" = mkMerge [{
          source = "${homeDir}/.config/yabai/yabairc";
          onChange = ''
            "${homeDir}/.config/yabai/yabairc"
          '';
        }];
      }

      {
        "skhd/skhdrc" = mkMerge [{
          source = "${homeDir}/.config/skhd/skhdrc";
          onChange = ''
            launchctl stop org.nixos.skhd
            launchctl start org.nixos.skhd
          '';
        }];
      }
    ];
  };
}
