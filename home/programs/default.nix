# programs/default.nix
# Userland programs

{ lib, ... }:
# { ... }:
let
  # Recursively gathers Nix files to import
  gatherImports = path:
    let
      contents = builtins.readDir path;
    in
    builtins.mapAttrs
      (name: value:
        let
          absolutePath = path + "/${name}";
          isNixFile = value == "regular" && builtins.match ".*\\.nix$" name != null;
          isDirectory = value == "directory";
          isModule = isDirectory && builtins.readDir absolutePath ? "default.nix";
        in
        # modules won't be searched for other modules
        if isModule then absolutePath
        # directories which are not themselves modules should be searched for imports
        else if isDirectory then gatherImports absolutePath
        # nix files that are not in modules are themselves modules to import
        else if isNixFile && name != "default.nix" then absolutePath
        else null
      )
      contents;

  # Transforms the attribute set into a list of import paths
  transformImports = attrSet: lib.collect lib.isPath attrSet;

  imports = transformImports (gatherImports ./.);

  # Transforms the allImports attribute set into a list of import paths
  # imports = lib.flatten (transformImports allImports);
in
{
  inherit imports;
}
