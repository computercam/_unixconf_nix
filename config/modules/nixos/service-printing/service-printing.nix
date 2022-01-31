{ config, lib, pkgs, options, ... }: {
  imports = [ ../service-avahi/service-avahi.nix ];

  config = {
    programs.system-config-printer.enable = true;
    services.system-config-printer.enable = true;

    services.printing = {
      enable = true;

      drivers = with pkgs; [
        canon-cups-ufr2
        carps-cups
        epson-escpr
        epson-escpr2
        gutenprint
        hplip
        splix
      ];
    };

    users.users.main.extraGroups = [ "lp" "printadmin" "scanner" ];
  };
}
