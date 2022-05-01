{ config, pkgs, ...}:
let 
   rytec-nl_nixpkgs = pkgs.fetchFromGitHub {
      owner = "rytec-nl";
      repo = "nixpkgs";
      rev = "submit/add-nomachine-server";
      sha256 = "sha256:02rka5nvdpay1wm8w5k0yaig509nh6apdzpj4wdvjhhdwgsv5q2d";
   };
    nomachine-server = pkgs.callPackage "${rytec-nl_nixpkgs}/pkgs/tools/admin/nomachine/default.nix" {};
in {
    config.nixpkgs.overlays = [ (final: prev: { nomachine = nomachine-server; })];
}