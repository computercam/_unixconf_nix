{ config, lib, pkgs, options, ... }: {
  config = {
    nix.settings.allowed-users = [ "work" ];

    users.groups.work.name = "work";
    
    users.users.work = {
      extraGroups = [ "sshusers" "docker" ];
      group = config.users.groups.work.name;
      isNormalUser = true;
      name = "work";
      shell = pkgs.zsh;
      packages = with pkgs; [
          ferdium
          maven
          nodejs-slim-14_x
          slack
          teams
      ];
    };

    home-manager.users.work = {
      home.stateVersion = config.cfg.os.version;

      home.packages = config
        .home-manager
        .users
        ."${config.cfg.user.name}"
        .home
        .packages;

      programs.zsh = {
        enable = true;

        initExtra = config
          .home-manager
          .users
          ."${config.cfg.user.name}"
          .programs
          .zsh
          .initExtra;
      };
    };

    programs.java = {
      enable = true;
      package = with pkgs; jdk11;
    };

    nixpkgs.config.permittedInsecurePackages = [];

    networking.firewall.allowedTCPPorts = [ 
      4502 
      4503 
      80 
      443
    ];
    
    networking.hosts = { 
      "127.0.0.1" = [ 
        "devixd-aem.toyota.com"
        "devixd-aem-ssl.toyota.com"
        "devixd-aem-author-ssl.toyota.com"
      ]; 
    };
  };
}
