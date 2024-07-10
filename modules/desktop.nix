{ pkgs, user, ... }:
{
  # Global theme stuff
  catppuccin.enable = true;
  catppuccin.flavor = "macchiato";

  programs = {
    dconf.enable = true;
    light.enable = true;
  };

  hardware.bluetooth.enable = true;

  console.useXkbConfig = true;

  security.pam.services.hyprlock = { };
  security.rtkit.enable = true; # for pipewire

  services = {
    dbus.packages = [ pkgs.gcr ];
    getty.autologinUser = "${user}";
    gvfs.enable = true;
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # jack.enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true; # might be a good idea?
    # configPackages = [ pkgs.gnome.gnome-session ];
    # (to keep < 1.17 behaviour) use the first portal implementation found in lexicographical order 
    # config.common.default = "*";
    config.common.default = "gtk";
    # config.common.default = "hyprland";
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-hyprland ];
  };

  systemd = {
    # user.services.polkit-gnome-authentication-agent-1 = {
    #   description = "polkit-gnome-authentication-agent-1";
    #   wantedBy = [ "graphical-session.target" ];
    #   wants = [ "graphical-session.target" ];
    #   after = [ "graphical-session.target" ];
    #   serviceConfig = {
    #     Type = "simple";
    #     ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    #     Restart = "on-failure";
    #     RestartSec = 1;
    #     TimeoutStopSec = 10;
    #   };
    # };
    user.services.polkit-kde-agent-1 = {
      description = "polkit-kde-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  environment = {
    variables.NIXOS_OZONE_WL = "1";
    systemPackages = with pkgs; [
      linux-wifi-hotspot
      linux-firmware
      libnotify
      wl-clipboard
      wlr-randr
      wayland
      # wayland-protocols
      wayland-scanner
      wayland-utils
      wev
      wf-recorder
      xwayland
      # egl-wayland
      # glfw-wayland
      qt6.qtwayland
      # qt6Packages.qt6ct
      libsForQt5.qt5.qtwayland
      # libsForQt5.qt5ct
      libva
      libva-utils
      playerctl
      pulseaudio # for pactl ig
      pulsemixer
      pavucontrol
      grim
      slurp
      # lxappearance
      # glib # gsettings
      # gnome.gnome-tweaks
      # gnome.dconf-editor
      # polkit_gnome
      # sshpass
    ];
  };
}
