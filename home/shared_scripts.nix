{ pkgs, ... }:
{
  fuzzel-powermenu = pkgs.writeShellScriptBin "fuzzel-powermenu" ''
    SELECTION="$(printf "1 - Lock\n2 - Suspend\n3 - Log out\n4 - Reboot\n5 - Reboot to UEFI\n6 - Shutdown" | fuzzel --dmenu -l 6 -p "Power Menu: ")"

    case $SELECTION in
    	*"Lock")
    		pidof hyprlock || hyprlock;;
    	*"Suspend")
    		systemctl suspend;;
    	*"Log out")
    		exit;;
    	*"Reboot")
    		systemctl reboot;;
    	*"Reboot to UEFI")
    		systemctl reboot --firmware-setup;;
    	*"Shutdown")
    		systemctl poweroff;;
    esac
  '';
  # cava-internal = pkgs.writeShellScriptBin "cava-internal" ''
  #   cava -p ~/.config/cava/config_internal | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;'
  # '';
}
