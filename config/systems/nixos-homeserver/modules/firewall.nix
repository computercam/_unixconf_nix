{ config, lib, pkgs, options, ... }: {
  config = {
    networking.firewall.allowedTCPPorts = [
      # 139
      # 22 
      # 443 
      # 445 
      # 4502 
      # 4503 
      # 80 
      # 8000 
      # 8443 
      # 8888 
      # 5555
      # 9000 
    ];
  };
}
