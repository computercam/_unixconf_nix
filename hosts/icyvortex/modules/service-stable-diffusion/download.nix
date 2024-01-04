{ pkgs ? import <nixpkgs> { } }:

pkgs.dockerTools.buildImage {
  name = "stable-diffusion-webui-download";
  tag = "latest";
  copyToRoot = [ 
    ./download-root
    pkgs.dockerTools.caCertificates
    pkgs.parallel 
    pkgs.aria2
    pkgs.coreutils
    pkgs.bash
  ];
  runAsRoot = ''
    chmod +x /download/download.sh
  '';
  config = {
    EntryPoint = [ "/download/download.sh" ];
  };
}
