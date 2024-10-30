{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # gnome-font-viewer
    # noto-fonts
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "CascadiaCode" "Monaspace" "Noto" "JetBrainsMono" ]; })
  ];

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      monospace = [ "JetBrainsMono NF" "CaskaydiaCove NF" "MonaspiceNe NF" ];
      serif = [ "NotoSerif NF" ];
      sansSerif = [ "NotoSans NF" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
