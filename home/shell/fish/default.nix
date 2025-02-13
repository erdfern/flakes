{ self, config, nixosConfig, pkgs, lib, ... }:
{
  programs.fish = {
    enable = true;

    plugins = with pkgs.fishPlugins; [
      # { name = "bass"; src = bass.src; } # bash utility compat
      # { name = "colored-man-pages"; src = colored-man-pages.src; } # `man`-wrapper
      { name = "plugin-git"; src = plugin-git.src; } # git aliases
    ];

    loginShellInit = lib.mkIf config.wayland.windowManager.hyprland.enable ''
      set TTY1 (tty)
      # [ "$TTY1" = "/dev/tty1" ] && exec dbus-run-session Hyprland
      [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
    '';

    interactiveShellInit = ''
      set fish_greeting ""

      if command -q nix-your-shell
        nix-your-shell fish | source
      end
    '';

    shellAliases = {
      # s = "kitty +kitten ssh";
      l = "ls -ahl";
      hf = ''hx (FZF_DEFAULT_COMMAND='fd' FZF_DEFAULT_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'" fzf --height 60% --layout reverse --info inline --border --color 'border:#b48ead')'';
      r = "yazi";
      top = "btop";
    };

    functions = {
      f = ''
        FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git' FZF_DEFAULT_OPTS="--color=bg+:#4C566A,bg:#424A5B,spinner:#F8BD96,hl:#F28FAD  --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96  --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD --preview 'bat --style=numbers --color=always --line-range :500 {}'" fzf --height 60% --layout reverse --info inline --border --color 'border:#b48ead'
      '';
      # ndev = ''
      #   set -gx devenv_files_path  "$HOME/.local/state/devenvs$(pwd)"
      #   set -f return_to $(pwd)
      #   mkdir -p $devenv_files_path
      #   cd $devenv_files_path
      #   nix develop --impure ${self}\#$argv[1] --command fish -C "cd $return_to" # this will put us into the dir we called ndev from
      #   cd $return_to # on exiting the nix dev shell, this will, again, return us to the initial PWD
      # '';
    };
  };

  home.file = {
    # ".config/fish/functions/fish_prompt.fish".source = ./functions/fish_prompt.fish;
    # ".config/fish/conf.d/nord.fish".text = import ./nord_theme.nix;
    ".config/fish/functions/owf.fish".source = ./functions/owf.fish;
    # ".config/fish/functions/yy.fish".source = ./functions/yy.fish;
    ".config/fish/functions/xdg-get.fish".text = import ./functions/xdg-get.nix;
    ".config/fish/functions/xdg-set.fish".text = import ./functions/xdg-set.nix;
  };
}
