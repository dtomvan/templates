{ lib, inputs, ... }:
{
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.raw;
    default = { };
  };

  imports = [ inputs.flake-parts.flakeModules.modules ];
}
