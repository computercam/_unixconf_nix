{ config, lib, pkgs, options, ... }: {
  config.services.cron.systemCronJobs = [
    "15   */6  *   *   *  root     rsync -avzh --min-size=1 /Volumes/Storage/ /Volumes/Backup/Storage/"
    "15   */12 *   *   *  root     rsync -avzh --min-size=1 /Volumes/Server/docker/ /Volumes/Backup/Server/docker/"
    "30   */4  *   *   *  cameron  rsync -avzh --min-size=1 /Volumes/Server/docker/gitea/git/repositories/ /Volumes/Storage/Cameron/Git/"
    # "45   2    */7 *   *  root     cd /Volumes/Server/ && ./docker_snapshot.sh"
  ];
}
