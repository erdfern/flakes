Adapted from https://github.com/Ruixi-rebirth/flakes

Starting from the minimal installation ISO image:

```sh
sudo -i
nix-shell -p git
git clone https://github.com/erdfern/flakes.git
cd flakes
nix develop --extra-experimental-features "nix-command flakes" --accept-flake-config
chmod +x lib/scripts/*
./lib/scripts/disko.sh
# if using lanzaboote, configure keys etc. before installing: https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
./lib/scripts/install.sh
```
