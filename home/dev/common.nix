{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # devenv
      surrealdb
    ];
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    gh-dash = {
      enable = true;
      catppuccin.enable = true;
    };
  };
}
