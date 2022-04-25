{ config, lib, pkgs, options, ... }: {
  config.services.cron.systemCronJobs = [
    # "15   */6 *   *   *  root     rsync -avzh --min-size=1 /Volumes/Storage/ /Volumes/Backup/Storage/"
    "45   2   */7 *   *  root     cd /Volumes/Server/ && ./docker_snapshot.sh"
    "30   6   *   *   *  cameron  cd /Volumes/Storage/Cameron/Software/github-mirror/ && ./mirror.sh"
  ];
}
