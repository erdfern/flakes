{ ... }:
{
  programs.starship = {
    enable = true;

    settings = {
      format = "$all";
      add_newline = false;
      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };
    };
  };
}
