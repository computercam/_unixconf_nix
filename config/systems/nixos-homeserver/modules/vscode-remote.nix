{ config, pkgs, ... }: {
  imports = [
    (fetchTarball
      "https://github.com/msteen/nixos-vscode-server/tarball/master")
  ];

  services.vscode-server.enable = true;
}
# https://hackmd.io/mLxjbE1jQwydlGXBA3UnkA?view#Solution
# make sure to run this as your user after importing this
# systemctl --user enable auto-fix-vscode-server.service
