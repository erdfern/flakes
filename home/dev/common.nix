{ pkgs, ... }:
{
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "CascadiaCode" "Monaspace" ]; })
  ];

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      monospace = [ "Noto Sans Mono" ];
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      emoji = [ "Twemoji" ];
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
