{ ... }:
{
  programs = {
    btop = {
      enable = true;
      catppuccin.enable = true;
      # settings = {
      # color_theme = "nord";
      # };
    };
  };
  # home.file = {
  # ".config/btop/themes/nord.theme".source = ./theme.nix;
  # };
}
