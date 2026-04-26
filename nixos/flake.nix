{
  description = "NixOS configuration of Jane Doe";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { withSystem, ... }:
      {
        systems = import inputs.systems;

        perSystem =
          { system, ... }:
          {
            _module.args.pkgs = import inputs.nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
          };

        flake.nixosConfigurations.jdoe = inputs.nixpkgs.lib.nixosSystem {
          modules = [
            ./systems/jdoe
            (withSystem "x86_64-linux" (
              { pkgs, system, ... }:
              {
                nixpkgs = {
                  inherit pkgs;
                  hostPlatform = system;
                };
              }
            ))
          ];
        };
      }
    );
}
