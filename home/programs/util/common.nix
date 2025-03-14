{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      tokei
      tree
      unar
      jq
      tldr
      rclone
      glow
      # obsidian
      # logseq
      # poppler

      # protonvpn-cli_2
    ];
  };
  programs.lsd = {
    enable = true;
    # ls = "${pkgs.lsd}/bin/lsd";
    # ll = "${pkgs.lsd}/bin/lsd -l";
    # la = "${pkgs.lsd}/bin/lsd -A";
    # lt = "${pkgs.lsd}/bin/lsd --tree";
    # lla = "${pkgs.lsd}/bin/lsd -lA";
    # llt = "${pkgs.lsd}/bin/lsd -l --tree";
    enableAliases = true;
  };
  programs.gh = {
    enable = true;
    extensions = [ pkgs.gh-copilot ];
  };
}
