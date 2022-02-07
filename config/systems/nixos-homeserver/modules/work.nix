{ config, lib, pkgs, options, ... }: {
  config = {
    nix.allowedUsers = [ "work" ];

    users.users.work = {
      extraGroups = [ "work" "sshusers" "docker" ];
      group = "work";
      home = "/Volumes/Storage/Work";
      initialPassword = "work";
      isNormalUser = true;
      name = "work";
      shell = pkgs.zsh;
    };

    users.groups.work.name = "work";

    networking.firewall.allowedTCPPorts = [ 4502 4503 80 ];

    programs.java = {
      enable = true;
      package = with pkgs; jdk11;
    };

    environment.systemPackages = with pkgs; [
      git
      docker
      #     nodejs-10_x 
      nodejs-14_x
      maven
    ];

    #   nixpkgs.config.permittedInsecurePackages = [
    #     "nodejs-10.24.1"
    #   ];

    networking.hosts = { "127.0.0.1" = [ "devixd-aem.toyota.com" ]; };
  };
}
