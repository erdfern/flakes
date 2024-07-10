# just-flake (see flake.nix)
import 'just-flake.just'

set shell := ["bash", "-uc"]
# set shell := ["bash", "-c"]

default:
    # if [ -z ${FLAKE_ROOT+x} ]; then nix develop --accept-flake-config; else echo "var is set to '$FLAKE_ROOT'"; fi
    if [ -z ${FLAKE_ROOT+x} ]; then echo "FLAKE_ROOT not set"; else echo "FLAKE_ROOT is set to '$FLAKE_ROOT'"; fi
    @just --list

disko:
    echo "Running disko script..."
    ./lib/scripts/disko.sh

install:
    echo "Running install script..."
    ./lib/scripts/install.sh

rebuild:
    [ -z "$FLAKE_ROOT" ] && echo "Entering dev shell" && nix develop --accept-flake-config
    echo "Running rebuild script"
    ./lib/scripts/rebuild.sh

dry-build:
    [ -z "$FLAKE_ROOT" ] && echo "Entering dev shell" && nix develop --accept-flake-config
    echo "Dry building flake config"
    ./lib/scripts/dry_build.sh
