{ inputs, ... }:
{
  flake-file.inputs.systems.url = "github:nix-systems/x86_64-linux";
  systems = import inputs.systems;
}
