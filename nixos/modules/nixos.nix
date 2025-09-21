{ inputs, self, ... }:
{
  flake.nixosConfigurations.jdoe = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.modules.nixos; [
      ./_hardware-configuration.nix
      base
      firefox
      # don't change this if you don't know what you're doing
      # read https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion first
      { system.stateVersion = "25.11"; }
    ];
  };
}
