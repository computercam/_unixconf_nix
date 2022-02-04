{ config, lib, pkgs, options, ... }: 
let cfg = config.cfg;
in {
  config.services.cron = { 
    mailto = cfg.user.email;
    enable = true; };
}
