# https://github.com/koekeishiya/yabai
# https://github.com/koekeishiya/skhd

{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.cfg;

  homeDir = builtins.getEnv ("HOME");

  yabai = pkgs.callPackage ./yabai-package.nix {
    inherit (pkgs.darwin.apple_sdk.frameworks) Carbon Cocoa ScriptingBridge;
  };

  skhd = pkgs.skhd;

in {
  imports = [ ./options.nix ];

  config = mkMerge [
    (mkIf (cfg.yabai.enable) {
      security.accessibilityPrograms =
        [ "${yabai}/bin/yabai" "${skhd}/bin/skhd" ];

      environment.systemPackages = [ yabai skhd ];

      launchd.daemons.yabai-sa = {
        script = ''
          if [ ! $(${yabai}/bin/yabai --check-sa) ]; then
            ${yabai}/bin/yabai --load-sa
            ${yabai}/bin/yabai --install-sa
          fi
        '';

        serviceConfig.RunAtLoad = true;
        serviceConfig.KeepAlive.SuccessfulExit = false;
      };

      launchd.user.agents.yabai = {
        serviceConfig.ProgramArguments =
          [ "${yabai}/bin/yabai" "-c" "${homeDir}/.config/yabai/yabairc" ];
        serviceConfig.KeepAlive = true;
        serviceConfig.ProcessType = "Interactive";
      };

      launchd.user.agents.skhd = {
        serviceConfig.ProgramArguments =
          [ "${skhd}/bin/skhd" "-c" "${homeDir}/.config/skhd/skhdrc" ];
        serviceConfig.KeepAlive = true;
        serviceConfig.ProcessType = "Interactive";
      };

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
    })
  ];
}
