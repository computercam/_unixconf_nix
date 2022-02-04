{ config, lib, pkgs, options, ... }: {
  config.services.cron.systemCronJobs = [
    # "0 */6 * * *  root  rsync -avzh --update --size-only /srv/sharedfolders/Cameron/* /srv/sharedfolders/Backup/"
    # "0 */6 * * *  root  rsync -avzh --update --size-only /home/cameron/.config/syncthing/* /srv/sharedfolders/Backup/"
  ];
}
