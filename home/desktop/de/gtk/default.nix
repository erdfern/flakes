{ pkgs, config, ... }:
{
  # needed for xdg-open? also TODO move
  systemd.user.sessionVariables = config.home.sessionVariables;

  # gtk settings viewer/editor
  # home.packages = with pkgs; [ nwg-look kdePackages.breeze-gtk kdePackages.breeze-icons kdePackages.breeze ];

  qt.enable = true;
  qt.platformTheme.name = "kvantum";
  qt.style.name = "kvantum";
  # home.sessionVariables = {
    # home.sessionVariables = { QT_QPA_PLATFORMTHEME = "gtk3"; GTK_THEME = config.gtk.theme.name; };
    # GTK_THEME = config.gtk.theme.name;
  # };
  # home.pointerCursor = {
  # name = "phinger-cursors-dark";
  # package = pkgs.phinger-cursors;
  # size = 24;
  # gtk.enable = true;
  # };
  catppuccin.pointerCursor.enable = true;
  gtk = {
    enable = true;
    catppuccin.enable = true;
    catppuccin.icon.enable = true;
    # theme = {
    # name = "Breeze-Dark";
    # name = "catppuccin-${config.catppuccin.flavor}-${config.catppuccin.accent}-compact+default";
    # package =
    #   (pkgs.catppuccin-gtk.overrideAttrs {
    #     src = pkgs.fetchFromGitHub {
    #       owner = "catppuccin";
    #       repo = "gtk";
    #       rev = "v1.0.3";
    #       fetchSubmodules = true;
    #       hash = "sha256-q5/VcFsm3vNEw55zq/vcM11eo456SYE5TQA3g2VQjGc=";
    #     };
    #     postUnpack = "";
    #   }).override
    #     {
    #       accents = [ config.catppuccin.accent ];
    #       variant = config.catppuccin.flavor;
    #       size = "compact";
    #     };
    # };
    # iconTheme = {
    #   name = "Papirus-Dark";
    #   package = pkgs.catppuccin-papirus-folders.override {
    #     flavor = config.catppuccin.flavour; # flavour, flavor... meh.
    #     accent = config.catppuccin.accent;
    #   };
    # };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };
  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark"; # NO IDEA why this doesn't get set by either gtk3.extraConfig or the catppuccin integration...
  };
}
