{ config, pkgs, user, ... }:
# let
#   nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
#     export __NV_PRIME_RENDER_OFFLOAD=1
#     export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
#     export __GLX_VENDOR_LIBRARY_NAME=nvidia
#     export __VK_LAYER_NV_optimus=NVIDIA_only
#     exec "$@"
#   '';
# in
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "kor";

  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_6_11;
    kernelParams = [ "nvidia-drm.modeset=1" "fbdev=1" ];
  };

  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true; # expose /run/current-system/sw/lib/libtpm2_pkcs11.so
  security.tpm2.tctiEnvironment.enable = true; # TPM2TOOLS_TCTI and TPM2_PKCS11_TCTI env variables
  users.users.${user}.extraGroups = [ "tss" ]; # tss group has access to TPM devices

  services = {
    # tlp.enable = true;
    # auto-cpufreq.enable = true;
    xserver.videoDrivers = [ "nvidia" ];
    # xserver.videoDrivers = [ "nouveau" ];
    # xserver.videoDrivers = [ "amdgpu" ];
  };

  hardware = {
    graphics.enable = true;
    graphics.extraPackages = with pkgs; [
      nvidia-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
      # mesa.drivers
      # amdvlk
    ];
    nvidia = {
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
      # package = config.boot.kernelPackages.nvidiaPackages.beta;
      package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
      open = false;
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement.enable = true; # suspend/wakeup issues
      # prime = {
      # offload.enable = true;
      # amdgpuBusId = "PCI:10:00:0";
      # nvidiaBusId = "PCI:01:00:0";
      # };
    };
    #graphics.extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
  };

  environment = {
    systemPackages = with pkgs; [
      # nvidia-offload
      glxinfo
      vulkan-validation-layers
      # steamcontroller # udev rules, i hope
    ];
  };

  systemd.tmpfiles.rules = [
    "L+ /run/nvidia-gpu - - - - /dev/dri/by-path/pci-0000:01:00.0-card"
    "L+ /run/amd-igpu - - - - /dev/dri/by-path/pci-0000:10:00.0-card"
  ];

  environment.variables = {
    AQ_DRM_DEVICES = "/run/amd-igpu:/run/nvidia-gpu";

    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";

    GBM_BACKEND = "nvidia-drm";
    __GL_GSYNC_ALLOWED = "1";
    __GL_VRR_ALLOWED = "0";
    # WLR_DRM_DEVICES = "/run/amd-igpu:/run/nvidia-gpu";
    # WLR_NO_HARDWARE_CURSORS = "1";
    # WLR_RENDERER_ALLOW_SOFTWARE = "1";
    #__NV_PRIME_RENDER_OFFLOAD = "1";
  };
}
