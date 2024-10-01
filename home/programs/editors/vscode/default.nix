{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    # programs.vscode.package = pkgs.vscode.fhsWithPackages (ps: with ps; [ rustup zlib openssl.dev pkg-config ]);
    package = pkgs.vscode.fhs;
    extensions = with pkgs.vscode-extensions; [
      ms-vscode-remote.remote-containers
      vscodevim.vim
      # yzhang.markdown-all-in-one
      ms-python.python
      # ms-toolsai.jupyter
    ];
  };
}
