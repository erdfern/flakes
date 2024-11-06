{ pkgs, user, config, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "kor-t14";

  boot = {
    # kernelPackages = pkgs.linuxPackages_xanmod_latest;
    # kernelParams = [ ];
  };

  # TODO move
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

  # security.tpm2.enable = true;
  # security.tpm2.pkcs11.enable = true; # expose /run/current-system/sw/lib/libtpm2_pkcs11.so
  # security.tpm2.tctiEnvironment.enable = true; # TPM2TOOLS_TCTI and TPM2_PKCS11_TCTI env variables
  # users.users.${user}.extraGroups = [ "tss" ]; # tss group has access to TPM devices

  services = {
    xserver.videoDrivers = [ "modesetting" ];
    # flatpak.enable = true;
    # tlp.enable = true; # succeeded by auto-cpufreq ig
    thermald.enable = true;
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
  };

  hardware = {
    graphics.enable = true;
    graphics.extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      # intel-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      powertop # for analyzing power consumption. Maybe also regulates power? Idk.
      glxinfo
    ];
  };

  environment.variables = {
    # LIBVA_DRIVER_NAME = "iHD";
    # WLR_RENDERER = "vulkan";
    WLR_NO_HARDWARE_CURSORS = "1";
    # WLR_RENDERER_ALLOW_SOFTWARE = "1";
  };
}
