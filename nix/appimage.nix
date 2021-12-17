{ pkgs ? import ./.,  sources ? import ./sources.nix }:
let
  emacsConfig = pkgs.runCommand "config.el" {} ''cat ${../elisp}/*.el > $out'';
  emacs-ng = (import sources.emacs-ng).outputs.defaultPackage.${builtins.currentSystem};
  emacsDist = pkgs.emacsWithPackagesFromUsePackage { # Why won't emacs-overlay grab my packages?
    package = emacs-ng;
    config = builtins.readFile emacsConfig.outPath;
    alwaysEnsure = true;
    extraEmacsPackages = e: [
      (emacs-webkit-f e)
    ];
  };
  emacs-webkit-f = p: import sources.emacs-webkit { inherit pkgs; inherit (p) trivialBuild; };
  emacs = emacs-ng.pkgs.withPackages (e: [(emacs-webkit-f e) e.evil]);
  bundle = import "${sources.nix-bundle}/appimage-top.nix" { nixpkgs' = sources.nixpkgs; }; 
in
with bundle; {
  result = appimage (appdir {name = "emacs"; target = emacsDist;});
  inherit emacs emacsDist emacs-webkit;
}
