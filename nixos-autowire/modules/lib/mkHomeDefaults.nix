{
  flake.lib.mkHomeDefaults =
    { user, stateVersion }:
    { lib, ... }:
    {
      home.username = lib.mkDefault user;
      home.homeDirectory = lib.mkDefault "/home/${user}";
      home.stateVersion = lib.mkDefault stateVersion;
    };
}
