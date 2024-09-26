{ pkgs, ... }:
{
 home.packages = (with pkgs; [
    signal-desktop
    # tdesktop
    # whatsapp-for-linux
  ]);
}
