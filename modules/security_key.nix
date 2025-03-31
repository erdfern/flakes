{ pkgs, ... }:
{
  # boot.initrd.luks.fido2Support = true;
  # Login functionality
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  # security.pam.yubico = {
  #   enable = true;
  #   debug = true;
  #   mode = "challenge-response";
  #   id = [ "22403841" ];
  # };

  # services.pcscd.enable = true; # NOTE: may conflict with gpg-agent

  # services.udev.packages = [ pkgs.yubikey-personalization ];

  environment.systemPackages = with pkgs; [
    nitrokey-udev-rules
    ccid # nitrokey
    opensc
    libfido2
    pam_u2f
    yubico-pam
    yubikey-manager
    yubikey-personalization
  ];
}
