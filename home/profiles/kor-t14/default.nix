{ ... }:
{
  imports = [
    ../../shell
    ../../dev
    ../../programs
  ] ++ [
    # ../../desktop/wm/niri
    ../../desktop/wm/hyprland
    ../../desktop/wall
  ];

  # xdg.mimeApps = {
  #   enable = true;
  #   # defaultApplications = {
  #   # "text/html" = "firefox.desktop";
  #   # "application/pdf" = "firefox.desktop";
  #   # "x-scheme-handler/http" = "firefox.desktop";
  #   # "x-scheme-handler/https" = "firefox.desktop";
  #   # };
  # };

  dconf.settings = {
    # Autostart QEMU/KVM in the first initialization of NixOS
    # realted link: https://nixos.wiki/wiki/Virt-manager
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
