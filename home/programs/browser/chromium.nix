{ ... }:
{
  programs.chromium = {
    enable = false;
    commandLineArgs = [ "--enable-features=UseOzonePlatform" "--ozone-platform=wayland" ];
    extensions =
      [
        # catppuccin macchiato theme
        { id = "cmpdlhmnmjhihmcfnigoememnffkimlk"; }
        # ublockOrigin
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
        # surfingkeys
        { id = "gfbliohnnapiefjpjlpjnehglfpaknnc"; }
        # proton pass
        { id = "ghmbeldphafepmbegfdlkpapadhbakde"; }
        # {
        #   id = "dcpihecpambacapedldabdbpakmachpb";
        #   updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/updates.xml";
        # }
      ];
  };
}
