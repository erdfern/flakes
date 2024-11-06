# lib/import.nix
{ lib, ... }:
let
  /**
    * Get a list of all items in a directory with their types
    * Returns an attrset of { name = type; } pairs
    */
  listDirectory = path:
    builtins.readDir path;

  /**
    * Convert a directory listing into a list of paths with their types
    * Returns a list of { path = path; name = name; type = type; }
    */
  makePathList = basePath: dirContent:
    lib.mapAttrsToList
      (name: type: {
        inherit type name;
        path = basePath + "/${name}";
      })
      dirContent;

  /**
    * Check if a path is a directory containing a default.nix file
    */
  isNixModule = path:
    let
      contents = builtins.readDir path;
    in
    contents ? "default.nix";

  /**
    * Filter directory entries to only Nix files, excluding default.nix
    */
  isRegularNixFile = entry:
    entry.type == "regular"
    && lib.hasSuffix ".nix" entry.name
    && entry.name != "default.nix";

  /**
    * Filter directory entries to only directories
    */
  isDirectory = entry: entry.type == "directory";

  /**
    * Get all regular Nix files from a directory (non-recursive)
    */
  getNixFiles = path:
    let
      contents = listDirectory path;
      entries = makePathList path contents;
    in
    builtins.filter isRegularNixFile entries;

  /**
    * Get all subdirectories from a directory
    */
  getDirectories = path:
    let
      contents = listDirectory path;
      entries = makePathList path contents;
    in
    builtins.filter isDirectory entries;

  /**
    * Get all Nix modules (directories with default.nix) from a directory
    */
  getNixModules = path:
    let
      dirs = getDirectories path;
    in
    builtins.filter (entry: isNixModule entry.path) dirs;

  /**
    * Recursively get all Nix files and modules from a directory
    */
  getRecursiveNixFiles = path:
    let
      # Get immediate Nix files
      nixFiles = getNixFiles path;

      # Get immediate Nix modules
      nixModules = getNixModules path;

      # Get subdirectories that aren't modules
      subDirs = builtins.filter
        (entry: !isNixModule entry.path)
        (getDirectories path);

      # Recursively process subdirectories
      subDirFiles = lib.flatten
        (map (entry: getRecursiveNixFiles entry.path) subDirs);
    in
    nixFiles ++ nixModules ++ subDirFiles;

  /**
    * Filter paths based on include/exclude patterns
    */
  filterPaths = { includePatterns ? [ ], excludePatterns ? [ ] }:
    let
      matchesAnyPattern = patterns: path:
        lib.any (pattern: builtins.match pattern path != null) patterns;

      shouldIncludePath = entry:
        if includePatterns != [ ] then
          matchesAnyPattern includePatterns entry.path
        else if excludePatterns != [ ] then
          !(matchesAnyPattern excludePatterns entry.path)
        else
          true;
    in
    builtins.filter shouldIncludePath;

  /**
    * Convert entry list to path list
    */
  toPaths = entries:
    map (entry: entry.path) entries;

  /**
    * Import all Nix files from a directory (non-recursive)
    */
  importNixFiles = path:
    toPaths (getNixFiles path);

  /**
    * Import all Nix modules from a directory
    */
  importNixModules = path:
    toPaths (getNixModules path);

  /**
    * Import all Nix files and modules recursively
    */
  importRecursiveNixFiles = path:
    toPaths (getRecursiveNixFiles path);

  /**
    * Create a module that imports paths based on the given function
    */
  makeModule = fn: path: patterns: {
    imports =
      if patterns != { } then
        toPaths (filterPaths patterns (fn path))
      else
        toPaths (fn path);
  };
in
{
  # Low-level functions for custom composition
  inherit
    listDirectory
    makePathList
    getNixFiles
    getNixModules
    getDirectories
    getRecursiveNixFiles
    filterPaths
    toPaths;

  # High-level functions for common use cases
  inherit
    importNixFiles
    importNixModules
    importRecursiveNixFiles;

  # Module creators for different import strategies
  makeFileModule = makeModule getNixFiles;
  makeModuleModule = makeModule getNixModules;
  makeRecursiveModule = makeModule getRecursiveNixFiles;
}
