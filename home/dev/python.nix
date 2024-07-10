{ pkgs, ... }:
let
  pyPackages = ps: with ps; [
    pip
    black
    ruff-lsp
    python-lsp-server
    python-lsp-ruff
    # rope
    # pyflakes
    # mccabe
    # pycodestyle
    # pydocstyle
    # autopep8
    # flake8
    # pylint
    # pytest
  ];
in
{
  # home = {
  #   packages = with pkgs; [
  #     (python3.withPackages pyPackages)
  #     pyright
  #     ruff
  #   ];
  # };
}
