{ config, lib, pkgs, ... }:
with pkgs.stdenv; {
  imports = [ ./options.nix ];

  config = {
    nix.allowedUsers = [ config.cfg.user.name ];

    environment.systemPackages = with pkgs; [ vim alacritty vscode ];

    environment.variables = {
      TERMINAL = "alacritty";
      EDITOR = "vim";
      VISUAL = "code";
    };

    users.users.main = {
      initialPassword = config.cfg.user.name;
      name = config.cfg.user.name;
      home = if isLinux then
        "/home/${config.cfg.user.name}"
      else if isDarwin then
        "/Users/${config.cfg.user.name}"
      else
        "/home/${config.cfg.user.name}";
      group = config.cfg.user.name;
      createHome = true;
      extraGroups = if isLinux then
        [ "wheel" ]
      else if isDarwin then
        [ "staff" ]
      else
        "/home/${config.cfg.user.name}";
      isNormalUser = true;
      shell = pkgs.zsh;
    };

    users.groups.main = { name = config.cfg.user.name; };

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
