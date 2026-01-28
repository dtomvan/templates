{
  self,
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (inputs.nixpkgs.lib)
    filterAttrs
    hasInfix
    mapAttrs'
    nameValuePair
    nixosSystem
    pipe
    ;

  makeNixos =
    _key: host:
    nameValuePair host.hostName (nixosSystem {
      modules = [
        (self.lib.system host.system)
        { networking = { inherit (host) hostName; }; }
        self.modules.nixos."hosts-${host.hostName}"
      ];
    });
in
{
  options.hosts = lib.mkOption {
    description = "an inventory of all systems configured using this flake";
    type = with lib.types; attrsOf raw;
    default = { };
  };

  config.flake.nixosConfigurations = pipe config.hosts [
    (filterAttrs (_k: v: hasInfix "linux" v.system))
    (mapAttrs' makeNixos)
  ];
}
