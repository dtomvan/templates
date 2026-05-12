{
  description = "Generic devshell flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      imports = [
        inputs.treefmt-nix.flakeModule
      ];

      perSystem =
        { pkgs, ... }:
        let
          inherit (pkgs)
            ;
        in
        {
          treefmt = {
            programs.nixfmt.enable = true;
          };

          packages.default = pkgs.callPackage (
            { lib, stdenv }:
            stdenv.mkDerivation (finalAttrs: {
              pname = "hello";
              version = "0";

              nativeBuildInputs = [ ];

              buildInputs = [ ];

              src = lib.fileset.toSource {
                root = ./.;
                fileset = lib.fileset.unions [
                ];
              };

              meta = {
                description = "";
                homepage = "";
                changelog = "";
                licenses = with lib.licenses; [ ];
                maintainers = with lib.maintainers; [ ];
              };
            })
          ) { };

          devShells.default = pkgs.mkShell {
            packages = [
            ];

            env = {
            };

            shellHook = "";
          };
        };

      flake = {
      };
    };
}
