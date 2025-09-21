{ inputs, ... }:
{
  imports = [
    inputs.flake-file.flakeModules.default
    inputs.flake-parts.flakeModules.modules
  ];

  flake-file.inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    flake-file.url = "github:vic/flake-file";
  };
}
