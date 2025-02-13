{ pkgs, ... }:
{
  home.packages = (with pkgs; [ nemo-with-extensions ]);
  # home.packages = (with pkgs; [ xfce.thunar lxqt.pcmanfm-qt]);
}
