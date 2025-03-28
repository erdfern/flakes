{ pkgs, ... }:
{
  home.packages = (with pkgs; [ nemo-with-extensions ]);
  xdg.desktopEntries.nemo = {
    name = "Nemo";
    exec = "${pkgs.nemo-with-extensions}/bin/nemo";
  };
  dconf.settings."org/cinammon/desktop/applications/terminal".exec = "kitty";
}
