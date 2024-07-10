{
  # nixpkgs.overlays = [ (final: prev: { programs.zathura = prev.programs.zathura.overrideAttrs { catppuccin.enable = false; }; }) ];
  programs.zathura = {
    enable = true;
    catppuccin.enable = true;
    catppuccin.flavor = "latte";
    extraConfig = ''
      # Zathura configuration file
      # See man `man zathurarc'

      # Open document in fit-width mode by default
      set adjust-open "best-fit"

      # One page per row by default
      set pages-per-row 1

      #stop at page boundries
      set scroll-page-aware "true"
      set scroll-full-overlap 0.01
      set scroll-step 100

      #zoom settings
      set zoom-min 10
      set guioptions ""

      set font "DaddyTimeMono Nerd Font 15"

      set statusbar-h-padding		10
      set statusbar-v-padding		10

      set selection-notification	"true"

      set render-loading "false"
      set scroll-step 50

      set selection-clipboard clipboard
    '';
  };
}
