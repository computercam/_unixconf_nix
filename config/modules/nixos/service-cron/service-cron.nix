{ config, lib, pkgs, options, ... }: {
  config = { services.cron = { enable = true; }; };
}
