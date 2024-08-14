{pkgs, ...}:
{
  home.packages = [pkgs.haskellPackages.git-annex];
  programs = {
    git-cliff.enable = true;
    git = {
      enable = true;
      lfs.enable = true;
      userName = "erdfern";
      userEmail = "rexsomnia@pm.me";
      # signing = {
      # key = "55C1AB28"; # on Yubi
      # signByDefault = false;
      # };
      delta = {
        # syntax highlighting pager
        enable = true;
        catppuccin.enable = true;
        options.navigate = true;
      };
      extraConfig = {
        core.exludesFile = "~/.gitignore_global";
        merge.conflictstyle = "diff3"; # "merge";
        merge.ff = true;
        diff.colorMoved = "default";
        url = {
          "ssh://git@github.com:erdfern/" = {
            insteadOf = "https://github.com/erdfern/";
          };
        };
      };
    };
  };

  home.file.".gitignore_global".text = ''
    .direnv
  '';
}
