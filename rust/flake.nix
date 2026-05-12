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

    fenix = {
      url = "github:nix-community/fenix";
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
        { pkgs, inputs', ... }:
        let
          inherit (pkgs)
            rust-analyzer
            rustfmt
            # stable
            rustc
            cargo
            ;

          # nightly
          # inherit (inputs'.fenix.legacyPackages.default)
          #   rustc
          #   cargo
          #   ;
        in
        {
          treefmt = {
            programs.nixfmt.enable = true;
            programs.rustfmt.enable = true;
          };

          packages.default = pkgs.callPackage (
            { lib, rustPlatform }:
            (rustPlatform.override { inherit rustc cargo; }).buildRustPackage (finalAttrs: {
              pname = "hello";
              version = "0";

              nativeBuildInputs = [ ];

              buildInputs = [ ];

              src = lib.fileset.toSource {
                root = ./.;
                fileset = lib.fileset.unions [
                  ./Cargo.toml
                  ./Cargo.lock
                  ./src
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
              rustc
              cargo
              rust-analyzer
              rustfmt
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
