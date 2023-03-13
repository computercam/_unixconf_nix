{ pkgs, ... }: {
  imports = [ <agenix/modules/age.nix> ];

  environment.systemPackages = with pkgs; [ 
    (callPackage <agenix/pkgs/agenix.nix> {})
    age
  ];

  age.identityPaths = [ ../../../../_/id_rsa ];
}
