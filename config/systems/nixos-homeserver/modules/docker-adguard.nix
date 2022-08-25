{ config, lib, pkgs, options, ... }: {
  config = {
    virtualisation.oci-containers.containers = {
      adguard = {
        image = "adguard/adguardhome";
        ports = [
          "3000:3000/tcp"
          # "443:443"
          "53:53"
          "5443:5443"
          "67:67/udp"  
          "68:68/udp"
          "784:784/udp"
          "5380:5380/tcp" # admin panel
          "853:853"
          "8853:8853/udp"
        ];
        volumes = [
          "/Volumes/Server/docker/adguardhome/work:/opt/adguardhome/work"
          "/Volumes/Server/docker/adguardhome/conf:/opt/adguardhome/conf"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Chicago";
        };
        extraOptions = [ 
          "--network=host"
          # "--label=swag=enable"
        ];
      };
    };

    networking.firewall.allowedTCPPorts = [
      3000
      # 443
      53
      5443
      5380
      853
    ];

    networking.firewall.allowedUDPPorts = [
      # 443
      53
      5443
      67
      68
      784
      853
      8853
    ];
  };
}
