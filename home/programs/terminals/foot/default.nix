{ ... }:
{
  programs.foot = {
    enable = false;

    settings = {
      main = {
        term = "xterm-256color";
        font = "monospace:size=16";
        dpi-aware = "yes";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
