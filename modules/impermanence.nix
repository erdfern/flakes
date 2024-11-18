{ user, ... }:
{
  environment = {
    persistence."/nix/persist" = {
      directories = [
        "/etc/nixos" # bind mounted from /nix/persist/etc/nixos to /etc/nixos
        "/etc/NetworkManager/system-connections"
        "/var/log"
        "/var/lib"
        "/etc/secureboot"
      ];
      files = [
      # TODO: fix persisting machine-id
      "/etc/machine-id"
      #   "/etc/create_ap.conf"
      ];
      users.${user} = {
        directories = [
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          "Flakes"
          "Games"
          "Kvm"
          "Projects"
          ".cache"
          ".config"
          ".local"
          { directory = ".gnupg"; mode = "0700"; }
          { directory = ".ssh"; mode = "0700"; }
          ".nv"
          ".mozilla"
          ".steam"
          ".gradle"
          ".cargo"
        ];
        files = [ ".nvidia-settings-rc" ];
      };
    };
  };
}
