{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    dtomvan = {
      url = "github:dtomvan/puntbestanden";
      flake = false;
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      flake-parts,
      import-tree,
      nixpkgs,
      dtomvan,
      disko,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        flake-parts.flakeModules.modules
        (import-tree "${dtomvan}/modules/community/autounattend")
      ];

      systems = [ "x86_64-linux" ];

      autounattend = {
        # needed so the installer partitions the same way you mount your
        # filesystems later
        diskoFile = ./disko.nix;
        # this path will be copied to /etc/nixos after installation.
        configRoot = ./.;
      };

      flake.nixosConfigurations.autounattend = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          ./disko.nix
          disko.nixosModules.disko
        ];
      };
    };
}
