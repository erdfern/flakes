{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome-font-viewer
    # noto-fonts
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "CascadiaCode" "Monaspace" ]; })
  ];

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      monospace = [ "MonaspiceNe NF" "CaskaydiaCove NFM" ];
      serif = [ "MonaspiceXe NF" ];
      sansSerif = [ "MonaspiceNe NF" "CaskaydiaCove NFM" ];
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
