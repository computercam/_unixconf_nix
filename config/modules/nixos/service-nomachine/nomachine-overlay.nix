{ config, pkgs, ...}:
let 
   rytec-nl_nixpkgs = pkgs.fetchFromGitHub {
      owner = "rytec-nl";
      repo = "nixpkgs";
      rev = "submit/add-nomachine-server";
      sha256 = "sha256:7ng6alhIrbJsdnmmMzUeO1YrrorRH7WN6RFyfW/z2Bo=";
   };
    nomachine-server = pkgs.callPackage "${rytec-nl_nixpkgs}/pkgs/tools/admin/nomachine/default.nix" {};
in {
    config.nixpkgs.overlays = [ (final: prev: { nomachine = nomachine-server; })];
}
