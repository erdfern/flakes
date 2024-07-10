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

  # systemd.user.sessionVariables = config.home.sessionVariables;
  # https://github.com/NixOS/nixpkgs/issues/189851#issuecomment-1238907955
  # systemd.user.extraConfig = ''
  #   DefaultEnvironment="PATH=/run/current-system/sw/bin"

  # '';
  # systemd.user.extraConfig = ''
  #   DefaultEnvironment="PATH=/run/wrappers/bin:/etc/profiles/per-user/%u/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
  # '';
  home.stateVersion = "24.11";
}
