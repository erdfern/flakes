{ pkgs, ... }:
{
  programs.fuzzel = {
    enable = true;

    settings = {
      # main = {icon-theme = config.gtk.iconTheme.name;};
      colors = {
        # catpuccin macchiato
        background = "24273add";
        text = "cad3f5ff";
        match = "ed8796ff";
        selection = "5b6078ff";
        selection-match = "ed8796ff";
        selection-text = "cad3f5ff";
        border = "b7bdf8ff";
      };
    };
  };
}
