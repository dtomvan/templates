{
  description = "mdbook";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      perSystem =
        { pkgs, ... }:
        let
          inherit (pkgs)
            mdbook
            ;
        in
        {
          packages.default = pkgs.runCommand "mdbook-book" { nativeBuildInputs = [ mdbook ]; } ''
            cp -r ${./.} src
            chmod -R +w src
            mdbook build src -d $out
          '';
          devShells.default = pkgs.mkShell {
            packages = [
              mdbook
            ];
          };
        };
    };
}
