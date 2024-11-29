{ pkgs, ... }:
let
  wallpaper = pkgs.fetchurl {
    url = "https://i.redd.it/mvev8aelh7zc1.png";
    hash = "sha256-lJjIq+3140a5OkNy/FAEOCoCcvQqOi73GWJGwR2zT9w";
  };
  catppuccin-wall = builtins.path {
    path = ./wallcat.png;
    # name = "wallcat";
  };
  whale = builtins.path { path = ./whale.jpg; };
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = "2.0";
      # preload = [ (builtins.toString wallpaper) ];
      preload = [ wallpaper catppuccin-wall whale ];
      # wallpaper = [ ", ${builtins.toString wallpaper}" ];
      # wallpaper = [ ", $HOME/Pictures/whale.jpg" ];
      wallpaper = [
        ", ${catppuccin-wall}"
        ", ${whale}"
        ", ${wallpaper}"
      ];
    };
  };
}
