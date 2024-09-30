{ pkgs, ... }:
{
  programs.vscode = {
    enable = false;
    # programs.vscode.package = pkgs.vscode.fhsWithPackages (ps: with ps; [ rustup zlib openssl.dev pkg-config ]);
    package = pkgs.vscode.fhs;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      yzhang.markdown-all-in-one
      ms-python.python
      ms-toolsai.jupyter
    ];
  };
}
