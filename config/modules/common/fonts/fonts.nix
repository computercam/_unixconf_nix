{ config, lib, pkgs, options, ... }: {
  config.fonts = {
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      fantasque-sans-mono
      fira-code
      terminus-nerdfont
      noto-fonts
      noto-fonts-emoji
      ubuntu_font_family
      victor-mono
    ];
    enableFontDir = true;
  };
}
