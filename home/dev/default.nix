# import all top level .nix files and/or directories
let
  directoryContents = builtins.readDir ./.;
  itemsToImport = builtins.filter
    (name:
      let
        itemType = directoryContents."${name}";
      in
      itemType == "regular" && name != "default.nix" && builtins.match ".*\\.nix$" name != null
    )
    (builtins.attrNames directoryContents);
  imports = map (name: ./. + "/${name}") itemsToImport;
in
{
  imports = imports;
}
