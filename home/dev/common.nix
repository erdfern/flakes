{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome-font-viewer
    # noto-fonts
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "CascadiaCode" "Monaspace" "Noto" ]; })
  ];

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      monospace = [ "MonaspiceAr NFP" "CaskaydiaCove NFM" "NotoMono NF" ];
      serif = [ "NotoSerif NF" ];
      sansSerif = [ "NotoSans NF" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  # home = {
  #   packages = with pkgs; [
  #     devenv
  #   ];
  # };

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
