{ pkgs, config, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    package = pkgs.steam.override {
      extraPkgs = pkgs: [
        pkgs.openssl_1_1
        (pkgs.callPackage ./../../pkgs/openldap_2_4.nix { })
        pkgs.libnghttp2
        pkgs.libidn2
        pkgs.rtmpdump
        pkgs.libpsl
      ];
      extraLibraries = pkgs: (with config.hardware.graphics;
        if pkgs.hostPlatform.is64bit
        then [ package ] ++ extraPackages
        else [ package32 ] ++ extraPackages32);
    };
  };

  # environment = {
  #   systemPackages = with pkgs; [ heroic ];
  # };
}
