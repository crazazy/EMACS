{ etsSrc ? (import ./sources.nix).elisp-tree-sitter, pkgs ? import ./., emacsDist ? pkgs.emacs.pkgs}:
let
  inherit (emacsDist) trivialBuild rust-mode async;
  inherit (pkgs.rustPlatform) buildRustPackage;

  rustCore = buildRustPackage {
    name = "tsc-src";
    src = "${etsSrc}/core";
    cargoHash = "sha256-7zFVz3i3oF3CCLZp+SCJar0GpmGfLDPSzUqGg7Zk/N8=";
  };
  tsc = trivialBuild { # not working
    pname = "tsc";
    src= "${etsSrc}/core";
    configurePhase = ''
      rm -r src/ Cargo*
      install ${rustCore}/lib/libtsc_dyn.so ./tsc_dyn.so
      sed -i 26,+4D tsc.el
    '';
  };
in
{ inherit rustCore; }
