{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nix-your-shell
  ];
  programs = {
    zoxide = {
      enable = true;
      options = [
        "--cmd j" # j, ji instead of z, zi
      ];
    };
  };
}
