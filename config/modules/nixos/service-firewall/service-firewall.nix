{ config, lib, pkgs, options, ... }:
with lib;
let
  cfg = config.cfg;
in
{
  config = {
    # Fail2Ban
    # Sane configurations are already enabled by default
    # Usage & Examples: https://github.com/fail2ban/fail2ban/blob/master/config/jail.conf
    services.fail2ban.enable = true;
  };
}
