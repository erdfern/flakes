{ lib, stdenv, fetchurl }:
stdenv.mkDerivation {
  pname = "zls-master";
  version = "0.0.1";
  src = fetchurl {
    url = "https://zig.erdfern.com/zls";
    sha256 = "sha256-4uHgwOVHSVHabVTidw5GnC8t6QCRkNXYQkLqLGfAu9c=";
  };
  dontUnpack = true;
  outputs = [ ];
  meta = {
    description = "zls";
    homepage = "https://github.com/zig-tools/zls";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    maintainers = [ lib.maintainers.erdfern ];
  };
}
