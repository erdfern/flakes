{ inputs, withSystem, module_args, config, lib, ... }:
let
  user = "lk";
  # domain = "keiser.co";

  sharedModules = [
    # (import ../desktop/theme { inherit user config lib; })
    module_args
    inputs.catppuccin.homeManagerModules.catppuccin
    inputs.nix-index-database.hmModules.nix-index
    inputs.nur.modules.homeManager.default
    (import ../. { inherit user config lib; })
    (import ../desktop/de)
  ];

  homeImports = {
    "${user}@kor" = [ ./kor ] ++ sharedModules;
    "${user}@kor-t14" = [ ./kor-t14 ] ++ sharedModules;
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in
{
  imports = [
    # we need to pass this to NixOS' HM module
    { _module.args = { inherit homeImports user; }; }
  ];

  flake = {
    homeConfigurations = withSystem "x86_64-linux" ({ pkgs, ... }: {
      "${user}@kor" = homeManagerConfiguration {
        modules = homeImports."${user}@kor";
        # extraSpecialArgs = { helix-flake = inputs.helix; };
        inherit pkgs config;
      };
      "${user}@kor-t14" = homeManagerConfiguration {
        modules = homeImports."${user}@kor-t14";
        # extraSpecialArgs = { helix-flake = inputs.helix; };
        inherit pkgs config;
      };
    });
  };
}
