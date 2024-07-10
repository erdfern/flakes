{ pkgs, inputs, ... }:
{
  # home.packages = [ inputs.zig-overlay.packages.${pkgs.system}.master pkgs.zls-master];
  # home.packages = [];
  # environment.etc."xdg/zls.json".text = let
  #   zig = inputs.zig.packages.${pkgs.system}.zig.master.bin;
  # in ''
  #   {
  #     "zig_exe_path": "${zig}/bin/zig",
  #     "zig_lib_path": "${zig}/lib",
  #     "warn_style": true,
  #     "highlight_global_var_declarations": true,
  #     "include_at_in_builtins": true,
  #     "enable_autofix": true
  #   }
  # '';
}

