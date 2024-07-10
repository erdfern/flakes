{ lib
, stdenv
, fetchFromGitHub
, zig
# , pkgs
# , inputs
, callPackage
}:

stdenv.mkDerivation {
  pname = "zls-master";
  version = "unstable-2024-05-10";

  src = fetchFromGitHub {
    owner = "zigtools";
    repo = "zls";
    rev = "bb19beeb38a8c3df9a2408b8e15664415b8347ef";
    hash = "sha256-43Mf2K/QS6dSm5OcnSvobkHNObyqFTSIxt7dtA/yrOo=";
    fetchSubmodules = true;
  };

  zigBuildFlags = [
    "-Dversion_data_path=${builtins.trace zig zig.src}/doc/langref.html.in"
  ];

  nativeBuildInputs = [
    zig
    # inputs.zig-overlay.packages.${pkgs.system}.master
  ];

  # postPatch = ''
  #   ln -s ${callPackage ./deps.nix { }} $ZIG_GLOBAL_CACHE_DIR/p
  # '';

  meta = with lib; {
    description = "A Zig language server supporting Zig developers with features like autocomplete and goto definition";
    homepage = "https://github.com/zigtools/zls";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "zls-master";
    inherit (zig.meta) platforms;
  };
}
