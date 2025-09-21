inputs@{ flake-parts, import-tree, ... }:
flake-parts.lib.mkFlake { inherit inputs; } (import-tree ./modules)
