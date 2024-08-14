{ pkgs, ... }:
{
  home.packages = with pkgs; [ fd ];
  programs = {
    ripgrep.enable = true;
    bat.enable = true;
    bat.catppuccin.enable = true;
    fzf.enable = true;
    fzf.catppuccin.enable = true;
  };
}
