{ config, lib, pkgs, ... }:
let
  # Rust Module definition
  myRustModule = { config, lib, ... }:
    with lib;
    let
      cfg = config.programs.rust;
      rustPkg = pkgs.rust-bin.selectLatestNightlyWith (toolchain: toolchain.default); # default or minimal
    in
    {
      options.programs.rust = {
        enable = mkEnableOption "Rust";

        package = mkOption {
          type = types.package;
          default = rustPkg;
          description = "The Rust package to use.";
        };

        rustAnalyzer = mkOption {
          type = types.package;
          default = pkgs.rust-analyzer;
          description = "The Rust Analyzer package to use for IDE support.";
        };

        # rustfmt = mkOption {
        #   type = types.package;
        #   default = pkgs.rustfmt;
        #   description = "The Rustfmt package to use for formatting Rust code.";
        # };
      };

      config = mkIf cfg.enable {
        home.packages = [ cfg.package cfg.rustAnalyzer ];
      };
    };
in
{
  imports = [ myRustModule ];

  programs.rust = {
    enable = false;
  };
}
