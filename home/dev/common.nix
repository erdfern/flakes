{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      gnumake
      lldb
      # ntfs3g
      # exercism
      # surrealdb
    ];
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    gh-dash = {
      enable = true;
      catppuccin.enable = true;
    };
    # vscode = {
    #   enable = true;
    #   extensions = with pkgs.vscode-extensions; [
    #     vscodevim.vim
    #     github.codespaces
    #     github.copilot
    #     github.copilot-chat
    #     eamodio.gitlens
    #   ];
    # };
  };
}
