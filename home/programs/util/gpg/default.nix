{ pkgs, ... }:
{
  programs.gpg.enable = true;
  programs.gpg.package = pkgs.gnupg;

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableScDaemon = true;
      # pinentryPackage = pkgs.pinentry-gnome3;
      pinentryPackage = pkgs.pinentry-curses;
    };
  };
}
