{ pkgs ? import ./.,  sources ? import ./sources.nix }:
let
  emacs-ng = pkgs.emacsWithPackagesFromUsePackage {
    package = (import sources.emacs-ng).outputs.defaultPackage.${builtins.currentSystem};
    config = "${../.}/init.el";
    alwaysEnsure = true;
    extraEmacsPackages = e: [
      emacs-webkit
    ];
  };
  emacs-webkit = import sources.emacs-webkit { inherit pkgs; };
  # emacs = emacs-ng.epkgs.withPackages (e: [emacs-webkit e.evil]);
  bundle = import "${sources.nix-bundle}/appimage-top.nix" { nixpkgs' = sources.nixpkgs; }; 
in
with bundle; {
  result = appimage (appdir {name = "emacs"; target = emacs-ng;});
  inherit emacs-ng emacs-webkit;
}
