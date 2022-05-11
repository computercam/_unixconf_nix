{ config, lib, pkgs, options, ... }: {
  config = {
    home-manager.users."${config.cfg.user.name}" = {
      home.packages = with pkgs; 
        if config.cfg.os.unix == "linux" then [
          exfat # filesystems
          ntfs3g # filesystems
          parted # filesystems
          
          nettools # networking
          openvpn # networking
        ] else if config.cfg.os.unix == "darwin" then [
        ] else [] ++
        [
          uutils-coreutils # generic _ rust alt - coreutils # https://github.com/uutils/coreutils
        
          bat # shell _ rust alt - cat & less # https://github.com/sharkdp/bat
          exa # shell _ rust alt - ls # https://github.com/ogham/exa
          zoxide # shell _ rust alt - cd # https://github.com/ajeetdsouza/zoxide
        
          findutils # search
          fzf # search
          ripgrep # search _ rust alt - find + grep # https://github.com/BurntSushi/ripgrep
        
          neofetch # system info
          lsof # system info
          procs # system info _ rust alt - ps # https://github.com/dalance/procs
        
          nmap # networking
          speedtest-cli # networking
        
          bzip2 # archives
          gzip # archives
          p7zip # archives
          unrar # archives
          unzip # archives
          zip # archives
        
          curl # file transfer
          rsync # file transfer and sync
          wget # file transfer
          youtube-dl # file transfer and downloader downloader
          lftp # file transfer
        
          pandoc # multimedia
          ffmpeg-full # multimedia
          imagemagick # multimedia
        ];
    };
  };
}

