{ pkgs, config, ... }:
{
  home.packages = with pkgs; [ android-studio-full android-studio-tools ];

  # android-sdk.enable = true;

  # # Optional; default path is "~/.local/share/android".
  # android-sdk.path = "${config.home.homeDirectory}/.android/sdk";

  home.sessionVariables = {
    ANDROID_HOME = "~/.local/share/android";
  };

  # android-sdk.packages = sdk: with sdk; [
  #   build-tools-34-0-0
  #   cmdline-tools-latest
  #   platform-tools
  #   emulator
  #   platforms-android-34
  #   sources-android-34
  #   system-images-android-34-google-apis-x86-64
  # ];
}
