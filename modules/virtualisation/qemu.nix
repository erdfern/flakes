#Qemu/KVM with virt-manager
{ pkgs, user, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      swtpm # TMP emulation
    ];
  };
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      # onBoot = "ignore";
    };
  };
  networking.firewall.trustedInterfaces = [ "virbr0" ];
  programs.dconf.enable = true;
  users.groups.libvirtd.members = [ "${user}" ];
}
