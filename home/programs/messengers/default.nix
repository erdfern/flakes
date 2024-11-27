{ pkgs, ... }:
{
  home.packages = (with pkgs; [
    signal-desktop
    discord
    # tdesktop
    # whatsapp-for-linux
  ]);
}
