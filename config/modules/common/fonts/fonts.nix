{ config, lib, pkgs, options, ... }: {
  config.fonts = {
    fonts = with pkgs; [
      # fantasque-sans-mono # included in nerdfonts
      # fira-code # included in nerdfonts
      # victor-mono # included in nerdfonts
      corefonts
      dejavu_fonts
      nerdfonts
      ubuntu_font_family
    ];
    fontDir.enable = true;
  };
}
