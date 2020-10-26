let
  sources = import ./sources.nix;
  inherit (sources) nixpkgs emacs-overlay;
  pkgs = import nixpkgs { overlays = [ emacs-overlay ]; };
in
  pkgs
