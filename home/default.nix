{ user, lib, ... }:
{
  programs.home-manager.enable = true;

  xdg.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = lib.mkDefault {
      "application/pdf" = [ "org.pwmt.zathura.desktop" "firefox.desktop" ];
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
    };
  };

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    language.base = "en_US.UTF-8";
    sessionVariables = {
      TERMINAL = "kitty";
      BROWSER = "firefox";
    };
  };

  home.stateVersion = "24.11";
}
