{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      devenv
      # jetbrains.rider
      # surrealdb
    ];
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    gh-dash.enable = true;
  };
}
