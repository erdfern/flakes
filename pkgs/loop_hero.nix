{ writeShellApplication, writeText, python3, steam-run }:

let
  app_id = 1282730;
  steam_path = "~/.steam/steam/steamapps/libraryfolders.vdf";
  get_steam_root_scripts =
    writeText "get_steam_root.py" # python
      ''
        import vdf
        import os

        app_id = ${app_id}
        steam_path = os.path.expanduser("${steam_path}")

        with open(steam_path, "r") as f:
           data = vdf.load(f)

        for library in data["libraryfolders"].values():
           if "apps" in library and str(${toString app_id}) in library["apps"]:
              print(library["path"])
      '';
in
writeShellApplication {
  name = "loop_hero";
  runtimeInputs = [
    (python3.withPackages (pythonPkgs: with pythonPkgs; [ vdf ]))
    steam-run
  ];
  text = # bash
    ''
      steam_root="$(python3 "${get_steam_root_scripts}")"
      cd "$steam_root/steamapps/common/Loop Hero"

      nixpkgs_flake="github:NixOS/nixpkgs"
      openldap_2_4_hash="3582135fe9589d0c823309cd38bebef37de369fd"
      openldap_2_4="$(nix build $nixpkgs_flake/$openldap_2_4_hash#openldap.out --no-link --print-out-paths)"
      openssl_1_1="$(export NIXPKGS_ALLOW_INSECURE=1; nix build nixpkgs#openssl_1_1.out --impure --no-link --print-out-paths)"

      export LD_LIBRARY_PATH="$openssl_1_1/lib:$openldap_2_4/lib:$LD_LIBRARY_PATH"

      steam-run ./run.sh
    '';
}
