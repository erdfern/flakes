{ pkgs, inputs, ... }:
let
  zig = pkgs.zigpkgs.master;
  zls = inputs.zls.packages.${pkgs.system}.zls.overrideAttrs (prev: {
    nativeBuildInputs = [ zig ];
  });
in
{
  # home.packages = [ inputs.zig-overlay.packages.${pkgs.system}.master pkgs.zls-master];
  home.packages = [ zig zls];
  home.file.".config/zls.json".text = ''
    {
      "$schema": "https://raw.githubusercontent.com/zigtools/zls/refs/heads/master/schema.json",
      "zig_exe_path": "${zig}/bin/zig",
      "zig_lib_path": "${zig}/lib"
    }
  '';
}

