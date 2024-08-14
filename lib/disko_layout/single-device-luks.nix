{ disks ? [ "/dev/nvme0n1" ], ... }:
{
  disko.devices = {
    disk.main = {
      device = builtins.elemAt disks 0;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            type = "EF02"; # for grub MBR
            size = "1M";
          };
          ESP = {
            type = "EF00";
            name = "ESP";
            size = "512M";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              initrdUnlock = true; # default is true anyway, but.. If true, boot.initrd.luks.devices.<name> is added.
              # disable settings.keyFile if you want to use interactive password entry
              askPassword = true;
              passwordFile = "/tmp/secret.key"; # Interactive
              settings = {
                # keyFile = "/tmp/secret.key";
                allowDiscards = true;
                crypttabExtraOpts = [ "fido2-device=auto" ];
                # fallbackToPassword = true; # implied by systemd stage 1
                # not supported by systemd stage 1
                #   preOpenCommands = '' # 
                #     sleep 2
                #   '';
              };
              # additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "/swap" = {
                    mountpoint = "/.swapvol";
                    swap.swapfile.size = "32G";
                  };
                };
              };
            };
          };
        };
      };
    };
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=12G"
        "mode=755"
        "defaults"
      ];
    };
  };
}
