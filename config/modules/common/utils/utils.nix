{ config, lib, pkgs, options, ... }: {
  config.environment.systemPackages = with pkgs;
  # TODO: Break Each of these categories out more intelligently
  # allow them to be pulled in or specified more modularly
  # TODO: Consider refactoring this file and shell.nix
    [
      # coreutils-full
      uutils-coreutils # generic _ rust alt - coreutils # https://github.com/uutils/coreutils
    ] ++ [
      # less # shell
      # sd # shell _ rust alt - sed # https://github.com/chmln/sd
      bat # shell _ rust alt - cat & less # https://github.com/sharkdp/bat
      dua # shell _ rust alt - du # https://github.com/Byron/dua-cli
      exa # shell _ rust alt - ls # https://github.com/ogham/exa
      zoxide # shell _ rust alt - cd # https://github.com/ajeetdsouza/zoxide
    ] ++ [
      # fd # search _ rust alt - find # https://github.com/sharkdp/fd
      # rustscan # search _ rust alt - nmap # https://github.com/RustScan/RustScan
      # skim # search _ rust alt - grep # https://github.com/lotabout/skim
      findutils # search
      fzf # search
      joshuto # search _ rust alt - ranger # https://github.com/kamiyaa/joshuto
      ripgrep # search _ rust alt - find + grep # https://github.com/BurntSushi/ripgrep
    ] ++ [
      # neofetch
      bottom # system info _ rust alt - htop # https://github.com/ClementTsang/bottom
      lsof # system info
      macchina # system info _ rust alt - neofetch # https://github.com/Macchina-CLI/macchina
      procs # system info _ rust alt - ps # https://github.com/dalance/procs
    ] ++ [
      bandwhich # networking _ rust alt - iftop # https://github.com/imsnif/bandwhich
      nettools # networking
      nmap # networking
      openvpn # networking
      speedtest-cli # networking
    ] ++ [
      bzip2 # archives
      gzip # archives
      p7zip # archives
      unrar # archives
      unzip # archives
      zip # archives
    ] ++ [
      curl # file transfer
      rsync # file transfer and sync
      wget # file transfer
      youtube-dl # downloader
    ] ++ [
      # apfs-fuse # filesystems
      # hfsprogs # filesystems
      # btrfs-progs # filesystems
      exfat # filesystems
      ntfs3g # filesystems
      parted # filesystems
    ] ++ [
      pandoc # multimedia
      ffmpeg-full # multimedia
      imagemagick # multimedia
    ];
}

