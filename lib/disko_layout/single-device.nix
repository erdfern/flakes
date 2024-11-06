{ disks ? [ "/dev/nvme0n1" ], ... }:
{
  disko.devices = {
    disk.main = {
      device = builtins.elemAt disks 0;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            priority = 1; # probably not needed
            name = "ESP";
            type = "EF00";
            start = "1M";
            end = "128M";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          root = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              mountpoint = "/partition-root";
              swap = {
                swapfile.size = "32G";
              };
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
