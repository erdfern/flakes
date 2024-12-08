{ pkgs, config, ... }:
# let
# homepage = pkgs.fetchurl {
#   url = "https://raw.githubusercontent.com/Ruixi-rebirth/someSource/main/firefox/homepage.html";
#   sha256 = "sha256-UmT5B/dMl5UCM5O+pSFWxOl5HtDV2OqsM1yHSs/ciQ4=";
# };
# bg = pkgs.fetchurl {
#   url = "https://raw.githubusercontent.com/Ruixi-rebirth/someSource/main/firefox/bg.png";
#   sha256 = "sha256-dpMWCAtYT3ZHLftQQ32BIg800I7SDH6SQ9ET3yiOr90=";
# };
# logo = pkgs.fetchurl {
#   url = "https://raw.githubusercontent.com/Ruixi-rebirth/someSource/main/firefox/logo.png";
#   sha256 = "sha256-e6L3xq4AXv3V3LV7Os9ZE04R7U8vxdRornBP5x4DWm8=";
# };
# in
{
  home = {
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_USE_XINPUT2 = "1";
    };
  };
  programs.firefox = {
    enable = true;
    package = (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { /*pipewireSupport = true;*/ })) {
      extraPolicies = {
        DisplayBookmarksToolbar = false;
        Preferences = {
          "browser.toolbars.bookmarks.visibility" = "never";
          "ui.key.menuAccessKeyFocuses" = false; # pressing ALT won't show menu bar
          # "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "media.ffmpeg.vaapi.enabled" = true;
        };
      };
    };
    profiles.default = {
      # id = 42;
      # name = "default";
      # path = "nix";
      isDefault = true;
      # search.default = "DuckDuckGo";
      # extensions = with config.nur.repos.rycee.firefox-addons; [
      #   tree-style-tab
      #   proton-pass
      #   # proton-vpn
      #   # firefox-color # not declarative :(
      #   # https://github.com/catppuccin/vimium - don't know how to add this declaratively :((
      #   vimium
      #   ublock-origin
      #   privacy-badger
      #   dictionary-german
      # ];
      # settings = {
      # "browser.startup.homepage" = "file://${homepage}";
      # };
      # userChrome ='''';
      # userContent = '''';
    };
  };
}
