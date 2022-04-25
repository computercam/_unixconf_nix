{ config, lib, pkgs, options, ... }: {
  config = {
    nix.allowedUsers = [ "work" ];

    users.groups.work.name = "work";

    users.users.work = {
      extraGroups = [ "work" "sshusers" "docker" ];
      group = "work";
      home = "/Volumes/Storage/Work";
      initialPassword = "work";
      isNormalUser = true;
      name = "work";
      shell = pkgs.zsh;
      packages = with pkgs; [
          nodejs-slim-10_x
          nodejs-10_x
          maven
      ];
    };

    programs.java = {
      enable = true;
      package = with pkgs; jdk11;
    };

    nixpkgs.config.permittedInsecurePackages = [
      "nodejs-10.24.1"
      "nodejs-slim-10.24.1"
      "electron-13.6.9"
      "electron-14.2.9"
    ];

    networking.firewall.allowedTCPPorts = [ 4502 4503 80 ];
    networking.hosts = { "127.0.0.1" = [ "devixd-aem.toyota.com" ]; };
  };
}
