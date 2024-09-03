{ pkgs, ... }:
let
  latexModule = { config, lib, ... }:
    let
      cfg = config.programs.latex;
    in
    {
      options.programs.latex = {
        enable = lib.mkEnableOption "LaTeX";

        texlive = lib.mkOption {
          type = lib.types.package;
          default = pkgs.texlive.combined.scheme-full;
          description = "The TeX Live package to use.";
        };

        texlab = lib.mkOption {
          type = lib.types.package;
          default = pkgs.texlab;
          description = "The TexLab package to use for LSP.";
        };
      };

      config = lib.mkIf cfg.enable {
        home.packages = [
          cfg.texlive
          cfg.texlab
        ];
      };
    };
in
{
  imports = [ latexModule ];

  programs.latex = {
    enable = true;
  };
}
