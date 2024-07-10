{ inputs
, sharedModules
, homeImports
, user
, ...
}: {
  flake.nixosConfigurations =
    let
      inherit (inputs.nixpkgs.lib) nixosSystem;
    in
    {
      kor = nixosSystem {
        specialArgs = { inherit user; };

        modules =
          [
            ./kor
            ../modules/impermanence.nix
            ../modules/desktop.nix
            ../modules/fonts.nix
            ../modules/virtualisation
            { home-manager.users.${user}.imports = homeImports."${user}@kor"; }
          ]
          ++ sharedModules;
      };

      kor-t14 = nixosSystem {
        specialArgs = { inherit user; };

        modules =
          [
            ./kor-t14
            ../modules/impermanence.nix
            ../modules/desktop.nix
            ../modules/fonts.nix
            ../modules/virtualisation
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14
            { home-manager.users.${user}.imports = homeImports."${user}@kor-t14"; }
          ]
          ++ sharedModules;
      };

      minimal = nixosSystem {
        specialArgs = { inherit user; };
        modules =
          [
            ./minimal
            ../modules/impermanence.nix
            # ../modules/systemdboot.nix
          ] ++ sharedModules;
      };
    };
}
