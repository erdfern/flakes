{ pkgs, user, ... }:

{
  users.mutableUsers = false;

  users.users.root = {
    initialHashedPassword = "$6$uO8KiiHgZIrxD.wh$hLFS5OBHalVOyZ1gH91U/M9xfnreZiIekuF8AsjXTXVo/5iJZuyl0iNOyI3RrDuMOLurAyZJrDVVHU/mtRTpX.";
  };

  users.users.${user} = {
    initialHashedPassword = "$6$uO8KiiHgZIrxD.wh$hLFS5OBHalVOyZ1gH91U/M9xfnreZiIekuF8AsjXTXVo/5iJZuyl0iNOyI3RrDuMOLurAyZJrDVVHU/mtRTpX.";
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
  };

  # Time and Locale
  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    # LC_CTYPE = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
    LC_COLLATE = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    # LC_MESSAGES = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_ADDRESS = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
  };


  # NOTE: https://github.com/Mic92/sops-nix#initrd-secrets
  # sops.defaultSopsFile = ../secrets/secrets.yaml;
  # sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  # sops.age.keyFile = "/var/lib/sops-nix/key.txt"; # You must back up this keyFile yourself
  # sops.age.generateKey = true;
  # issue: https://github.com/Mic92/sops-nix/issues/149
  # workaround:
  # systemd.services.decrypt-sops = {
  #   description = "Decrypt sops secrets";
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "network-online.target" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     RemainAfterExit = true;
  #     Restart = "on-failure";
  #     RestartSec = "2s";
  #   };
  # script = config.system.activationScripts.setupSecrets.text;
  # };


  security.rtkit.enable = true;
  security.polkit.enable = true;

  security.sudo = {
    enable = true;
    extraConfig = ''
      ${user} ALL=(ALL) NOPASSWD:ALL
    '';
  };

  security.doas = {
    enable = false;
    extraConfig = ''
      permit nopass :wheel '';
  };

  services = {
    dbus.enable = true;
    openssh = {
      enable = true;
      # authorisedKeys.keys = [];
    };
  };

  programs.fish.enable = true;

  networking = {
    networkmanager.enable = true;
    # hosts = {
    # };
  };

  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    shells = with pkgs; [ fish ];
    systemPackages = with pkgs; [
      # cacert # bundle of public Certificate Authorities. Probably installed by default???
      git
      gnumake
      just
      wget
      p7zip
      atool
      unzip
      zip
      rar
      xdg-utils
      pciutils
      killall
      # sops
    ];
  };

  system.stateVersion = "24.11";
}
