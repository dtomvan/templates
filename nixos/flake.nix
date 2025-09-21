{
  description = "NixOS configuration of Jane Doe";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    flake-file.url = "github:vic/flake-file";
    systems.url = "github:nix-systems/x86_64-linux";
  };

  outputs = inputs: import ./outputs.nix inputs;
}
