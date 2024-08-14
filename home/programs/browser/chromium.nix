{ ... }:
{
  programs.chromium = {
    enable = false;
    extensions =
      [
        # catppuccin macchiato theme
        { id = "cmpdlhmnmjhihmcfnigoememnffkimlk"; }
        # ublockOrigin
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
        # surfingkeys
        { id = "gfbliohnnapiefjpjlpjnehglfpaknnc"; }
        {
          id = "dcpihecpambacapedldabdbpakmachpb";
          updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/updates.xml";
        }
      ];
  };
}
