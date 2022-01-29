{ config, pkgs, lib, ... }: 
with pkgs.stdenv; with lib; 
{ 
  config.environment = mkMerge 
  [
    (mkIf isLinux {
      systemPackages = with pkgs; [
        dateutils
        killall
        lshw
        lsof
      ];
    })

    {
      systemPackages = with pkgs; [ 
        # generic
        coreutils-full
        uutils-coreutils
        parallel
        stow
        nixfmt
        # files
        findutils
        lsof
        rsync
        # multimedia
        ffmpeg-full
        imagemagick
        imlib2
        librsvg
        optipng
        # downloading 
        curl
        lftp
        wget
        # archives
        p7zip
        unrar
        unzip
        zip
        # networking
        iftop
        inetutils
        nmap
        speedtest-cli
        tcpdump
      ];
    }
  ];
}
