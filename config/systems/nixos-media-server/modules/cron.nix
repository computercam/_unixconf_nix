{ config, lib, pkgs, options, ... }:

with lib; {
  config = {
    services.cron = {
      enable = true;
      mailto = "csanders@protonmail.com";
      systemCronJobs = [
        "0 */6 * * *  root  rsync -avzh --update --size-only /srv/sharedfolders/Cameron/* /srv/sharedfolders/Backup/"
        "0 */6 * * *  root  rsync -avzh --update --size-only /home/cameron/.config/syncthing/* /srv/sharedfolders/Backup/"
      ];
    };
  };
}
