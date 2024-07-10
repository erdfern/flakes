{ self, inputs, ... }:
let
  # system-agnostic args
  module_args._module.args = {
    inherit inputs self;
  };
in
{
  imports = [
    {
      _module.args = {
        # we need to pass this to HM
        inherit module_args;

        # NixOS modules
        sharedModules = [
          module_args
          ./core.nix
          ./systemdboot.nix
          ./nix.nix
          ./security_key.nix
          # inputs.home-manager.nixosModules.home-manager # Same as below?
          inputs.home-manager.nixosModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
            };
          }
          inputs.catppuccin.nixosModules.catppuccin
          inputs.disko.nixosModules.disko
          inputs.impermanence.nixosModules.impermanence
          # inputs.sops-nix.nixosModules.sops
        ];
      };
    }
  ];

  flake.nixosModules = {
    # Plan to import custom modules for calling or exposing my own modules 
    # foo = import ./foo.nix;
  };
}
