{ config, pkgs, ... }: {
  imports = [ (fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/c54b714db58ad05d064f394d6603751ee6bd04f6") ];
  services.vscode-server.enable = true;
}
# https://hackmd.io/mLxjbE1jQwydlGXBA3UnkA?view#Solution
# make sure to run this as your user after importing this
# systemctl --user enable auto-fix-vscode-server.service
