{ config, lib, pkgs, options, ... }:

{
  config = {
    networking.firewall = {
      enable = false;
      # TODO: consider making these values configurable
      allowedTCPPorts = [];
    };
    # Fail2Ban
    # Sane configurations are already enabled by default
    # Usage & Examples: https://github.com/fail2ban/fail2ban/blob/master/config/jail.conf
    services.fail2ban.enable = true;
  };
}
