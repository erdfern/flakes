{ ... }:
{
  programs.foot = {
    enable = true;
    catppuccin.enable = true;

    settings = {
      main = {
        term = "xterm-256color";
        font = "jetbrains mono nerd font:size=14";
        dpi-aware = "yes";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
