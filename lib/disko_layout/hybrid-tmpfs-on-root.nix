{ ... }:
{
  disko.devices = {
    disk.main = {
      device = "/dev/nvme1n1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            size = "1M";
            type = "EF02"; # for grub MBR
          };
          ESP = {
            name = "ESP";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          root = {
            size = "100%";
            content = {
              # type = "filesystem";
              # format = "ext4";
              # mountpoint = "/nix";
              type = "btrfs";
              extraArgs = [ "-f" ];
              mountpoint = "/partition-root";
              swap.swapfile = { size = "20M"; };

              subvolumes = {
                "/nix" = { mountpoint = "/nix"; mountOptions = [ "compress=zstd" "noatime" ]; };
                "/swap" = {
                  mountpoint = "/.swapvol";
                  swap = {
                    swapfile.size = "32G";
                    # swapfile1.size = "20M";
                    # swapfile1.path = "rel-path";
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
        "size=8G"
        "defaults"
        "mode=755"
      ];
    };
  };
}
