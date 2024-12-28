{ pkgs, ... }:
let
  wallpapers = map builtins.toString [
    ../../../wall/strata.png
    ./whale.jpg
    ./astro.png
    ./wallcat.png
    ./bunnies-road.png
  ];

  wp = wallpaper: monitor: "${if monitor != null then monitor else ""}, ${builtins.toString wallpaper}";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = "2.0";
      preload = wallpapers;
      wallpaper = [
        (wp (builtins.elemAt wallpapers 0) null)
        # (wp (builtins.elemAt wallpapers 1) null)
        # (wp (builtins.elemAt wallpapers 2) null)
        # (wp (builtins.elemAt wallpapers 3) null)
      ];
    };
  };
}

# { pkgs, ... }:
# let
#   wallpaper = pkgs.fetchurl {
#     url = "https://i.redd.it/mvev8aelh7zc1.png";
#     hash = "sha256-lJjIq+3140a5OkNy/FAEOCoCcvQqOi73GWJGwR2zT9w";
#   };
#   catppuccin-wall = builtins.path {
#     path = ./wallcat.png;
#     # name = "wallcat";
#   };
#   whale = builtins.path { path = ./whale.jpg; };
#   bnuy = ./bunnies-road.png;
# in
