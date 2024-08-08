{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = builtins.trace "hihihi" pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      yzhang.markdown-all-in-one
      ms-python.python
      ms-toolsai.jupyter
    ];
  };
}
