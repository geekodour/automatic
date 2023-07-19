let
  pkgs = import <nixpkgs> {};
  pyPackages = pkgs.python310Packages;
  fhs = pkgs.buildFHSUserEnv {
    name = "normalfsshell";
    targetPkgs = pkgs: [pkgs.glib pkgs.libglvnd];
    runScript = "bash";
  };
in
  pkgs.mkShell {
    name = "py";
    venvDir = "./.venv";
    nativeBuildInputs = [ fhs ];
    buildInputs = with pyPackages; [ pip venvShellHook ];

    postShellHook = ''
      # allow pip to install wheels
      unset SOURCE_DATE_EPOCH
      normalfsshell
    '';
  }

