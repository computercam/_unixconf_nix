{ config, lib, pkgs, ... }:
with pkgs.stdenv; 
with lib; {
  imports = [ ./options.nix ];

  config = {
    nix.allowedUsers = [ config.cfg.user.name ];

    environment.systemPackages = with pkgs; [ vim alacritty vscode ];

    environment.variables = {
      TERMINAL = "alacritty";
      EDITOR = "vim";
      VISUAL = "code";
    };

    users.users.main = (mkMerge [
      (if config.cfg.os.unix == "linux" then {
        createHome = true;
        extraGroups = [ "wheel" ];
        group = config.cfg.user.name;
        home = "/home/${config.cfg.user.name}";
        initialPassword = config.cfg.user.name;
        isNormalUser = true;
       } else {})
       ( if config.cfg.os.unix == "darwin" then {
        home = "/Users/${config.cfg.user.name}";
       } else {})
       ({
         name = config.cfg.user.name;
         shell = pkgs.zsh;
       })
    ]);

    users.groups.main = (mkMerge [
      (if config.cfg.os.unix == "linux" then { 
        name = config.cfg.user.name; 
      } else {})
       ( if config.cfg.os.unix == "darwin" then { 
        name = "staff"; 
      } else {})
    ]);

    # home-manager.users.main = mkMerge [
    #   {
    #     programs.git = {
    #       enable = true;
    #       userName = config.cfg.user.name;
    #       userEmail = config.cfg.useremail;
    #     };
    #   }
    # ];
  };
}
