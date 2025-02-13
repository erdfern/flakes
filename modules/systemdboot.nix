{ ... }:
{
  catppuccin.plymouth.enable = true;
  boot = {
    # tmp
    supportedFilesystems = [ "ntfs" ];
    initrd.systemd.enable = true; # systemd-stage-1 
    initrd.verbose = false;
    consoleLogLevel = 0;
    plymouth = {
      enable = true;
    };
    bootspec.enable = true;
    loader = {
      timeout = 0; # if 0, press any key to show OS selection
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };
}
