#!/usr/bin/env bash
set -e

# if [[ -z "$FLAKE_ROOT" ]]; then
#     echo "FLAKE_ROOT environment variable is not set. You should probably enter the development environment for this flake using 'nix develop'."
#     exit 1
# fi

if [[ ! -d "/mnt/etc/nixos/Flakes" ]]; then
    echo "Partition and mount the filesystem. The directory /mnt/etc/nixos/Flakes does not exist."
    exit 1
fi

cd /mnt/etc/nixos/Flakes

host_configs=()
for file in "$FLAKE_ROOT/hosts"/*; do
    if [[ -d "$file" ]]; then # Check if it's a directory
        host_configs+=("${file##*/}") # Add just the directory name
    fi
done

if [[ ${#host_configs[@]} -eq 0 ]]; then
    echo "Error: No host configurations found in $FLAKE_ROOT/hosts"
    exit 1
fi

echo "The partition is now complete, please select the device you wish to install:"
select device in "${host_configs[@]}"; do
    if [[ -n $device ]]; then
        echo "Set password"
        passwd_hash=$(mkpasswd -m sha512crypt)
        sed -i "/initialHashedPassword/c\ \ \ \ initialHashedPassword\ =\ \"$passwd_hash\";" ./modules/core.nix
        echo "Password set"
        nixos-install --no-root-passwd --flake .#$device
        break
    else
        echo "Invalid choice, please try again."
    fi
done
