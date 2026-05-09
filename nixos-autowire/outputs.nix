inputs@{ nixpkgs, flake-parts, ... }:
let
  inherit (builtins)
    readDir
    attrNames
    concatMap
    ;

  inherit (nixpkgs.lib) hasPrefix hasSuffix;

  listFilesRecursiveCond =
    dir: condition:
    let
      internalFunc =
        folder:
        let
          contents = readDir folder;
        in
        concatMap (
          filename:
          let
            subpath = folder + "/${filename}";
            type = contents.${filename};
          in
          if condition { inherit filename type; } then
            if type == "regular" then
              [ subpath ]
            else if type == "directory" then
              internalFunc subpath
            else
              [ ]
          else
            [ ]
        ) (attrNames contents);
    in
    internalFunc dir;

  isNixFile =
    { filename, type }: (hasSuffix ".nix" filename || type == "directory") && !hasPrefix "_" filename;
  import-tree = dir: (listFilesRecursiveCond dir isNixFile);
in
flake-parts.lib.mkFlake { inherit inputs; } flake-parts.lib.mkFlake { inherit inputs; } {
  imports = import-tree ./modules;
}
