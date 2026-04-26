{ self, ... }:
{
  flake.modules.nixos.hosts-nixos = {
    imports = with self.modules.nixos; [
      ./_hardware-configuration.nix
      base
      users-alice
    ];
  };
}
