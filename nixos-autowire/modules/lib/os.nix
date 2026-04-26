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
    mkOption
    nameValuePair
    nixosSystem
    pipe
    ;

  inherit (lib.types)
    attrsOf
    listOf
    str
    submodule
    ;

  hostModule.options = {
    hostName = mkOption {
      description = "What the value of `networking.hostName' will be";
      type = str;
      example = "elated-minsky";
    };
    users = mkOption {
      description = "List of normal users to add *and* to instantiate a HM config for";
      type = listOf str;
      default = [ ];
      example = [
        "tomvd"
        "alice"
      ];
    };
    system = mkOption {
      description = "What the value of `nixpkgs.hostPlatform' will be";
      type = str;
      example = "x86_64-linux";
    };
    stateVersion = mkOption {
      description = "system.stateVersion";
      type = str;
      example = "26.05";
    };
  };

  makeNixos =
    _key: host:
    nameValuePair host.hostName (nixosSystem {
      modules = [
        (self.lib.system host.system)
        {
          networking = { inherit (host) hostName; };
          system = { inherit (host) stateVersion; };
        }
        self.modules.nixos."hosts-${host.hostName}"
      ]
      ++ (map (u: self.modules.nixos."users-${u}") host.users);
      specialArgs = { inherit host; };
    });
in
{
  options.hosts = lib.mkOption {
    description = "an inventory of all systems configured using this flake";
    type = attrsOf (submodule hostModule);
    default = { };
  };

  config.flake.nixosConfigurations = pipe config.hosts [
    (filterAttrs (_k: v: hasInfix "linux" v.system))
    (mapAttrs' makeNixos)
  ];
}
