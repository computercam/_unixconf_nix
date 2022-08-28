{ config, lib, pkgs, options, ... }:
let
  # https://github.com/paulyoung/pub2nix/blob/master/yaml.nix
  fromYAML = yaml: builtins.fromJSON (
    builtins.readFile (
      pkgs.runCommand "from-yaml"
        {
          inherit yaml;
          allowSubstitutes = false;
          preferLocalBuild = true;
        }
        ''
          ${pkgs.remarshal}/bin/remarshal  \
            -if yaml \
            -i <(echo "$yaml") \
            -of json \
            -o $out
        ''
    )
  );
  readYAML = path: fromYAML (builtins.readFile path);
in {
  config = {
    services.adguardhome = {
      enable = true;
      settings = readYAML ./AdGuardHome.yaml;
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
