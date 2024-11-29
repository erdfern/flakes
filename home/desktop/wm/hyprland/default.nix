{ inputs, pkgs, ... }:
{
  imports = [ ./config.nix ./hyprlock ./hyprpaper ];

  wayland.windowManager.hyprland = {
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlattform.system}.hyprland;
    enable = true;
    # TODO use UWSM
    # https://github.com/NixOS/nixpkgs/blob/4633a7c72337ea8fd23a4f2ba3972865e3ec685d/nixos/modules/programs/wayland/hyprland.nix#L55   
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = [ "--all" ];
    };
    xwayland.enable = true;
    plugins = [
      # inputs.hycov.packages.${pkgs.system}.hycov
    ];
  };

  home.packages = with pkgs;[
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    # inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
    hypridle
    pamixer
    # libsforQt5.qt5.qtwayland
    qt6.qtwayland
    # libsForQt5.qt5ct
    qt6Packages.qt6ct
  ];

  # systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

  home.sessionVariables = {
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    QT_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };
}
