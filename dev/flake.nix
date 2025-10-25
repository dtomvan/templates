{
  description = "Generic devshell flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # fenix = {
    #   url = "github:nix-community/fenix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      imports = [
        inputs.treefmt-nix.flakeModule
      ];

      perSystem =
        { pkgs, system, ... }:
        {
          treefmt = {
            programs.nixfmt.enable = true;
          };

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              # inputs.fenix.packages.${system}.minimal.toolchain
            ];

            env = {
            };

            shellHook = '''';
          };
        };

      flake = {
      };
    };
}
