{
  description = "Generic devenv flake";

  inputs = {
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
    devenv.url = "github:cachix/devenv";
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
        inputs.devenv.flakeModule
      ];

      perSystem =
        { pkgs, system, ... }:
        {
          treefmt = {
            programs.nixfmt.enable = true;
          };

          # https://devenv.sh/reference/options/
          devenv.shells.default = {
            packages = with pkgs; [
              # bun
            ];

            # languages.rust = {
            #   enable = true;
            #   toolchain = inputs.fenix.packages.${system}.minimal;
            # };
          };
        };

      flake = {
      };
    };
}
