{ pkgs, ... }:
{
  home.packages = [ pkgs.fastfetch ];
  home.file = {
    ".config/fastfetch/config.jsonc".source = ./all.jsonc;
    ".config/fastfetch/neofetch.jsonc".source = ./neofetch.jsonc;
  };
  home.shellAliases.neofetch = "fastfetch -c $XDG_CONFIG_HOME/fastfetch/neofetch.jsonc";
}
