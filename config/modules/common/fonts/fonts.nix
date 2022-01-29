{ config, lib, pkgs, options, ... }:
{ config.fonts = {
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      fantasque-sans-mono
      fira
      fira-code
      freefont_ttf
      gyre-fonts
      liberation_ttf
      terminus-nerdfont
      noto-fonts
      noto-fonts-emoji
      ubuntu_font_family
      unifont
      victor-mono
    ];
    
    enableFontDir = true;
  };
}
