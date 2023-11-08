# https://nixos.wiki/wiki/AMD_GPU
{ config, lib, pkgs, options, ... }: {
  imports = [
    (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master")
  ];

  services.vscode-server.enable = true;
}
