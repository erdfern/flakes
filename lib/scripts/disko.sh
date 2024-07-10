#!/usr/bin/env bash
set -e

if [[ -z "$FLAKE_ROOT" ]]; then
    echo "FLAKE_ROOT environment variable is not set. You should probably enter the development environment for this flake using 'nix develop'."
    exit 1
fi

common_dir="$FLAKE_ROOT/lib/disko_layout"

function askEdit {
    read -p "Would you like to edit this layout? (y/n): " yn
    case $yn in
        [yY]) hx $layout_path ;;
        [nN]) ;;
        * ) echo "Invalid response";
            exit 1 ;;
    esac
}

# Select the disk partition layout and edit it
layouts=(${common_dir}/*.nix) # Collect all .nix files in the common_dir directory
layouts=("${layouts[@]##*/}")  # Remove the common_dir prefix

echo "Please select a disk partition layout:"
select layout in "${layouts[@]}"; do
    if [[ -n $layout ]]; then
        echo "You have selected layout $layout"
        layout_path="${common_dir}/${layout}"
        askEdit
        break
    else
        echo "Invalid choice, please try again."
    fi
done

nix --extra-experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko "$layout_path"

mkdir -p /mnt/etc/nixos
mkdir -p /mnt/nix/persist/etc/nixos
mount -o bind /mnt/nix/persist/etc/nixos /mnt/etc/nixos
nixos-generate-config --no-filesystems --root /mnt
cd /mnt/etc/nixos
# TODO
cp hardware-configuration.nix "$FLAKE_ROOT"/hosts/kor/hardware-configuration.nix && cp hardware-configuration.nix "$FLAKE_ROOT"/hosts/minimal/hardware-configuration.nix

relative_path="../../lib/disko_layout"
layout_filepath="$relative_path/$(basename $layout_path)"

sed -i "/imports\ =/cimports\ = [(import\ $layout_filepath\ {})]++" "$FLAKE_ROOT"/hosts/**/hardware-configuration.nix
mkdir /mnt/etc/nixos/Flakes; cp -r "$FLAKE_ROOT/"* /mnt/etc/nixos/Flakes/ # maybe just copy into etc/nixos?
lsblk

echo "Might be a good time to enroll a security key for unlocking LUKS?"
