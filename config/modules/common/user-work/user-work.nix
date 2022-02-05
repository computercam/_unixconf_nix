{ config, lib, pkgs, ... }:
with pkgs.stdenv; {
  config = {
    users.users.work = {
      createHome = true;
      extraGroups = [ "work" "sshusers" "docker" ];
      group = "work";
      home = "/Volumes/work";
      initialPassword = "work";
      isNormalUser = true;
      name = "work";
      shell = pkgs.zsh;
    };

    users.groups.work.name = "work";
    
    networking.firewall.allowedTCPPorts = [ 4502 4503 80 ];
  };
}
