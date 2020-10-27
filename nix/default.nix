let
  sources = import ./sources.nix;
  inherit (sources) nixpkgs emacs-overlay;
  pkgs = import nixpkgs { overlays = [ (import emacs-overlay.outPath) ]; };
in
  pkgs
