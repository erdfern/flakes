{ pkgs, ... }:
let
  file-browser = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/Ruixi-rebirth/someSource/main/mpv/file-browser.lua";
    sha256 = "sha256-7Otm34EUdEzBVSZaBmyaZ+xdE4FV3sd3WFIxVKtC8U4=";
  };
in
{
  programs = {
    mpv = {
      enable = true;
      config = {
        # vo="gpu-next";  
        gpu-api = "opengl";
        gpu-context = "wayland";
        # hwdec="auto";
        hwdec = "auto-safe";
        vo = "gpu";
        profile = "gpu-hq";
        script-opts = "ytdl_hook-ytdl_path=yt-dlp";
      };
    };
  };
  home.file = {
    ".config/mpv/scripts/file-browser.lua".text = "${file-browser}";
  };
}
