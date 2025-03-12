{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      devenv
      nodePackages."@anthropic-ai/claude-code"
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
