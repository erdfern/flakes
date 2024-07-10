{
  programs = {
    kitty = {
      enable = true;
      catppuccin.enable = true;

      environment = { };
      keybindings = { };
      font.name = "jetbrains mono nerd font";
      font.size = 14;
      settings = {
        italic_font = "auto";
        bold_italic_font = "auto";
        mouse_hide_wait = -1; # hide on typing, else window manager should handle it
        cursor_shape = "block";
        # url_color = "#0087bd";
        url_style = "dotted";
        #Close the terminal =  without confirmation;
        confirm_os_window_close = 0;
        background_opacity = "0.9";
      };
    };
  };
}
