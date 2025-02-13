{ pkgs, ... }:
{
  home.packages = with pkgs; [ fd ];
  programs = {
    ripgrep.enable = true;
    bat.enable = true;
    fzf.enable = true;
  };
}
