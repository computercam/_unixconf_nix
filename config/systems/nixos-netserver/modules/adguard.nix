{ config, lib, pkgs, options, ... }: {
  config = {
    services.adguardhome = {
      enable = true;
      settings = builtins.readFile ./AdGuardHome.yaml;
    };

    networking.firewall.allowedTCPPorts = [
      3000
      53
      80
    ];

    networking.firewall.allowedUDPPorts = [
      443
      53
    ];
  };
}
