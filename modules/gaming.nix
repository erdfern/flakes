{ pkgs, config, ... }:
{
  programs.steam = {
    enable = false;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    package = pkgs.steam.override {
      extraLibraries = pkgs: (with config.hardware.graphics;
        if pkgs.hostPlatform.is64bit
        then [ package ] ++ extraPackages
        else [ package32 ] ++ extraPackages32);
    };
  };
}