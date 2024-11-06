{
  description = "rhabarber";

  outputs = { self, ... } @ inputs:
    let
      selfPkgs = import ./pkgs;
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [
        ./home/profiles
        ./hosts
        ./modules
      ] ++ [
        inputs.flake-root.flakeModule
        inputs.just-flake.flakeModule
        inputs.treefmt-nix.flakeModule
      ];
      # flake = { overlays.default = selfPkgs.overlay; };
      perSystem = { config, pkgs, system, ... }:
        {
          # NOTE: These overlays apply to the Nix shell only. See `modules/nix.nix` for system overlays.
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              #inputs.foo.overlays.default
            ];
          };
          devShells = {
            default = pkgs.mkShell {
              nativeBuildInputs = with pkgs; [ git helix sbctl just ];
              inputsFrom = [
                config.flake-root.devShell
                config.just-flake.outputs.devShell
                config.treefmt.build.devShell
              ];
            };
            # NOTE: Make sure you keep the id_rsa safe, or you won't be able to decrypt it. 
            # ```
            # mkdir -p ~/.config/sops/age
            # age-keygen -o ~/.config/sops/age/keys.txt
            # age-keygen -y ~/.config/sops/age/keys.txt
            # mkdir -p /var/lib/sops-nix
            # cp ~/.config/sops/age/keys.txt /var/lib/sops-nix/key.txt
            # nvim $FLAKE_ROOT/.sops.yaml
            # mkdir $FLAKE_ROOT/secrets
            # sops $FLAKE_ROOT/secrets/secrets.yaml
            # ```
            secret = with pkgs; mkShell {
              name = "secret";
              nativeBuildInputs = [ sops age helix ssh-to-age ];
              shellHook = ''
                export $EDITOR=hx
                export PS1="\[\e[0;31m\](Secret)\$ \[\e[m\]"
              '';
              inputsFrom = [
                config.flake-root.devShell
              ];
            };
            sk = with pkgs; mkShell {
              name = "sk";
              nativeBuildInputs = [
                nitrokey-app
                yubikey-manager
                yubikey-personalization
                # ccid
                # opensc
                # libfido2
                # pam_u2f
                # yubico-pam
              ];
              inputsFrom = [
                config.flake-root.devShell
              ];
            };
          };
          just-flake.features = {
            treefmt.enable = true;
            convco.enable = true;
          };
          # used by the `nix fmt` command
          # formatter = config.treefmt.build.wrapper;
          treefmt.config = {
            inherit (config.flake-root) projectRootFile;
            package = pkgs.treefmt;
            flakeCheck = true; # pre-commit-hooks checks this, too
            programs.nixpkgs-fmt.enable = true;
          };
        };
    };
  nixConfig = {
    trusted-users = [ "root" "@wheel" ];
    extra-substituters = [
      "https://nix-community.cachix.org"
      # "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
  inputs = {
    lix-module = { url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz"; inputs.nixpkgs.follows = "nixpkgs"; };

    # update single input: `nix flake lock --update-input <name>`
    # update all inputs: `nix flake update`
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    nix-index-database = { url = "github:Mic92/nix-index-database"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    disko.url = "github:nix-community/disko";
    impermanence.url = "github:nix-community/impermanence";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-root.url = "github:srid/flake-root";
    # sops-nix.url = "github:Mic92/sops-nix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    just-flake.url = "github:juspay/just-flake";

    # --- DE & Theming ---
    catppuccin.url = "github:catppuccin/nix";

    # --- WM ---
    # hyprland.url = "github:hyprwm/Hyprland?submodules=1";
    hypr-contrib = { url = "github:hyprwm/contrib"; inputs.nixpkgs.follows = "nixpkgs"; };
    # hyprland-plugins = { url = "github:hyprwm/hyprland-plugins"; inputs.hyprland.follows = "hyprland"; };
    # hyprpicker = { url = "github:hyprwm/hyprpicker"; inputs.nixpkgs.follows = "nixpkgs"; };
    # hyprland-hyprspace = { url = "github:KZDKM/Hyprspace"; inputs.hyprland.follows = "hyprland"; };
  };
}
