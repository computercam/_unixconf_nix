{ config, pkgs, ...}:
let 
   rytec-nl_nixpkgs = pkgs.fetchFromGitHub {
      owner = "rytec-nl";
      repo = "nixpkgs";
      rev = "submit/add-nomachine-server";
      sha256 = "sha256:18j9la8nqcvnikn0azvhx4nb80zyb75j8wkf7iw3fpx9ympic4xa";
   };
    nomachine-server = pkgs.callPackage "${rytec-nl_nixpkgs}/pkgs/tools/admin/nomachine/default.nix" {};
in {
    config.nixpkgs.overlays = [ (final: prev: { nomachine = nomachine-server; })];
}