{
  imports = [
    ./hardware-configuration.nix
    ../../modules/base.nix
    ../../modules/firefox.nix
  ];

  # don't change this if you don't know what you're doing
  # read https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion first
  system.stateVersion = "25.11";
}
