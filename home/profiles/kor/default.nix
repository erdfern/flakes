{ ... }:
{
  imports = [
    ../../shell
    ../../dev
    ../../programs
  ] ++ [
    ../../desktop/wm/hyprland
    ../../desktop/wall
  ];

  # wayland.windowManager.hyprland = lib.mkIf config.wayland.windowManager.hyprland.enable; # { enableNvidiaPatches = true; };

  # Autostart QEMU/KVM in the first initialization of NixOS
  # realted link: https://nixos.wiki/wiki/Virt-manager
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
