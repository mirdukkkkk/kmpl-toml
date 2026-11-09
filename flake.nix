{
  description = "kmpl-toml: a TOML reader for kmpl, written in kmpl";

  inputs = {
    kmpl.url = "github:mirdukkkkk/kmpl/v0.3.0";
    nixpkgs.follows = "kmpl/nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      kmpl,
      ...
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAll = f: nixpkgs.lib.genAttrs systems (s: f nixpkgs.legacyPackages.${s} s);
    in
    {
      devShells = forAll (
        pkgs: system: {
          default = pkgs.mkShell {
            packages = [
              kmpl.packages.${system}.default
              pkgs.stdenv.cc
            ];
          };
        }
      );
    };
}
