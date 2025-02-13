{ ... }:
let
  # baseTheme = builtins.fetchurl {
  #   url = "https://raw.githubusercontent.com/catppuccin/hyprland/main/themes/macchiato.conf";
  #   sha256 = "sha256:1f8fr5sf220g4pc7vcg2cs51rzp49a7dgr8rlwspybvmz9wdc3c8";
  # };
  # catTheme = builtins.toFile "macciatho.conf" ''
  #   ${builtins.readFile baseTheme}
  #   $accent = $maroon
  #   $accentAlpha = $maroonAlpha
  #   $font = JetBrainsMono Nerd Font
  # '';
in
{
  catppuccin.hyprlock = {
    enable = true;
    accent = "maroon";
    flavor = "mocha";
  };
  home.file.".config/.avatar".source = ./avatar.jpg;
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };
      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
  programs.hyprlock = {
    enable = true;

    # Gets placed at the bottom, so these declarations are forward referenced, which hyprlang doesn't seem to support
    # extraConfig = ''
    # source=${catTheme}
    #   $accent = $maroon
    #   $accentAlpha = $maroonAlpha
    #   $font = JetBrainsMono Nerd Font
    # '';

    settings = {
      # source = [ catTheme ];

      general = {
        grace = 5;
        disable_loading_bar = true;
        hide_cursor = true;
        ignore_empty_input = true;
      };

      background = [{
        path = "screenshot";
        color = "$base";

        blur_passes = 3;
        blur_size = 7;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      }];

      image = [{
        path = "$HOME/.config/.avatar";
        size = 100;
        border_color = "$accent";

        position = "0, 75";
        halign = "center";
        valign = "center";
      }];

      label = [
        {
          # TIME
          text = "cmd[update:30000] echo \"$(date +\"%R\")\"";
          color = "$text";
          font_size = 90;
          font_family = "$font";
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }
        {
          # DATE 
          text = "cmd[update:43200000] echo \"$(date +\"%A, %d %B %Y\")\"";
          color = "$text";
          font_size = 25;
          font_family = "$font";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }
      ];

      input-field = [{
        size = "300, 60";
        outline_thickness = 4;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "$accent";
        inner_color = "$surface0";
        font_color = "$text";
        # fade_on_empty = true
        # face_timeout = 5000 # fade?
        placeholder_text = "<i>Input Password...</i>";
        # placeholder_text = "<span foreground="##$textAlpha"><i>󰌾 Logged in as </i><span foreground="##$accentAlpha">$USER</span></span>"
        hide_input = false;
        check_color = "$accent";
        fail_color = "$red";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        capslock_color = "$yellow";
        position = "0, -35";
        halign = "center";
        valign = "center";
      }];
    };
  };
}
