#!/usr/bin/env bash
set -e

if [[ -z "$FLAKE_ROOT" ]]; then
    echo "FLAKE_ROOT environment variable is not set. You should probably enter the development environment for this flake using 'nix develop'."
    exit 1
fi

if command -v doas &> /dev/null; then
    CMD=doas
else
    CMD=sudo
fi

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

current_hostname=$(hostname)

for device in "${host_configs[@]}"; do
    if [[ "$device" == "$current_hostname" ]]; then
        echo "Found configuration matching current hostname ($current_hostname)"
        read -r -p "Use this configuration to rebuild? (Y/n) " yn
        case $yn in
            [nN] ) echo "Please choose a a host configuration";
                break ;;
            * ) $CMD nixos-rebuild switch --flake .#"$device" --accept-flake-config --upgrade;
                exit 0 ;;
        esac
    fi
done

select device in "${host_configs[@]}"; do
    if [[ -n $device ]]; then

        if [[ "$device" != "$current_hostname" ]]; then
            echo "WARNING: Selected device ($device) does not match current hostname ($current_hostname)"
            # read -p "Are you sure you want to continue? (y/n) " confirm
            # if [[ $confirm != "y" ]]; then
            #     echo "Rebuild cancelled."
            #     exit 1
            # fi
        fi

        $CMD nixos-rebuild switch --flake .#"$device" --accept-flake-config --upgrade
        break
    else
        echo "Invalid choice, please try again."
    fi
done
