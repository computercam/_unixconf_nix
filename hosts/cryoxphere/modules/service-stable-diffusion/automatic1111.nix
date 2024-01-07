{ pkgs ? import <nixpkgs> { } }:

pkgs.dockerTools.buildImage {
  name = "stable-diffusion-webui-automatic1111";
  tag = "latest";
  fromImage = pkgs.dockerTools.pullImage {
    imageName = "nvidia/cuda";
    imageDigest = "sha256:c518e52bb489a7cd466b802a467a11e316216041445d9d1da92f69752707edff";
    sha256 = "sha256-pZKfp3/aM9YDNUUTwR+QCzUJmb265WQ6sD8cu48oVIM=";
    finalImageTag = "12.3.1-runtime-ubuntu20.04";
    finalImageName = "nvidia/cuda";
  };
  # copyToRoot = [ 
    # ./automatic1111-root
    # pkgs.aria2
    # pkgs.bash
    # pkgs.cairo
    # pkgs.coreutils
    # pkgs.dejavu_fonts
    # pkgs.dockerTools.caCertificates
    # pkgs.ffmpeg
    # pkgs.git
    # pkgs.glfw
    # pkgs.glib
    # pkgs.jq
    # pkgs.mesa
    # pkgs.parallel 
    # pkgs.pkg-config
    # pkgs.python310
    # pkgs.python310Packages.pip
    # pkgs.rsync
    # pkgs.wget
  # ];
  runAsRoot = ''
    ls -alh /
    df -h
  '';
  # config = {
  #   EntryPoint = [ "/automatic1111/entrypoint.sh" ];
  # };
  diskSize = 4096;
  buildVMMemorySize = 4096;
}
