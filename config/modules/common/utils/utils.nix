{ config, lib, pkgs, options, ... }: {
  config.environment.systemPackages = with pkgs;
  # TODO: Break Each of these categories out more intelligently
  # allow them to be pulled in or specified more modularly
  # TODO: Consider refactoring this file and shell.nix
    [
      uutils-coreutils # generic _ rust alt - coreutils # https://github.com/uutils/coreutils
    ] ++ [
      bat # shell _ rust alt - cat & less # https://github.com/sharkdp/bat
      exa # shell _ rust alt - ls # https://github.com/ogham/exa
      zoxide # shell _ rust alt - cd # https://github.com/ajeetdsouza/zoxide
    ] ++ [
      findutils # search
      fzf # search
      joshuto # search _ rust alt - ranger # https://github.com/kamiyaa/joshuto
      ripgrep # search _ rust alt - find + grep # https://github.com/BurntSushi/ripgrep
    ] ++ [
      neofetch # system info
      lsof # system info
      procs # system info _ rust alt - ps # https://github.com/dalance/procs
    ] ++ [
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
      exfat # filesystems
      ntfs3g # filesystems
      parted # filesystems
    ] ++ [
      pandoc # multimedia
      ffmpeg-full # multimedia
      imagemagick # multimedia
    ];
}

