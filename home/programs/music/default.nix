{ pkgs, ... }:

{
  # home = {
  #   packages = with pkgs; [
  # mpc-cli
  # go-musicfox
  # youtube-music
  # ytmdl
  # ytermusic
  # ytui-music
  #   ];
  # };
  programs = {
    cava = {
      enable = false;
    };
  };
  # home.file = {
  # ".config/cava/config".source = ./cava_config;
  # ".config/cava/config_internal".source = ./cava_config_internal;
  # };

  # services = {
  #   mpd = {
  #     enable = true;
  #     musicDirectory = "~/Music";
  #     extraConfig = ''
  #       audio_output {
  #               type            "pipewire"
  #               name            "PipeWire Sound Server"
  #       }
  #     '';
  #   };
  # };
}
