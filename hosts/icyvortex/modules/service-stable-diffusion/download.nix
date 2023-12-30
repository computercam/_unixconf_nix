{ pkgs ? import <nixpkgs> { } }:

pkgs.dockerTools.buildImage {
  name = "stable-diffusion-webui-download";
  tag = "latest";
  fromImage = pkgs.dockerTools.pullImage {
    imageName = "bash";
    imageDigest =
      "sha256:553746463135eaae3f2c9bde1c4185ffc18efb24c7b75b8b096ffd6d3e63f2bf";
    arch = "amd64";
    sha256 = "sha256-QtPdbdWsS8hZyttFhF2YromMhWbCedcG4dSlORC85Bk=";
  };
  copyToRoot = pkgs.buildEnv {
    name = "download";
    paths = [ ./download ];
    pathsToLink = [ "/download" ];
  };
  runAsRoot = ''
    ls /download
    chmod +x /download/download.sh
    apk add parallel aria2
  '';
  config = {
    EntryPoint = [ "/download/download.sh" ];
  };
}
