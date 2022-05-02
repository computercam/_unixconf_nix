{ config, lib, pkgs, options, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
        python3Full
        python3Packages.pip
        nodejs
        nodePackages.npm
        cargo
        rustc
        distrobox
        vscode
    ];
  };
}
