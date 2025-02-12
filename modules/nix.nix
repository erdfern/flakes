{ pkgs, inputs, self, ... }:
{
  # To prevent "Too many open files" errors on rebuild
  systemd.extraConfig = "DefaultLimitNOFILE=4096";
  # nix.package = pkgs.nixVersions.git; # git for bleeding edge, latest otherwise | DON'T SET if using the lix module, overwrites the lix package
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.settings = {
    auto-optimise-store = true; # Optimise syslinks
    builders-use-substitutes = true;
    keep-derivations = true;
    keep-outputs = true;
    substituters = [
      "https://nix-community.cachix.org"
      # "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
    trusted-users = [ "root" "@wheel" ];
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 2d";
  };
  nixpkgs = {
    config = {
      # allowBroken = true;
      allowUnsupportedSystem = true;
      allowUnfree = true;
      # permittedInsecurePackages = [ "openssl-1.1.1w" ]; # loop heroo
    };
    overlays = [ self.overlays.default ] ++ [ inputs.zig-overlay.overlays.default ]; # ++ [ inputs.lix-module.overlays.default];
  };
  nix.extraOptions = ''
    experimental-features = nix-command flakes auto-allocate-uids
    keep-outputs          = true
    keep-derivations      = true
  '';
}
