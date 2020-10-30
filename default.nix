{ pkgs ? import <nixpkgs> { } }:
let
  inherit (pkgs) runCommand emacsWithPackages;
  inherit (builtins) attrNames concatStringsSep readDir foldl' readFile toFile;
  srcFiles = attrNames (readDir ./elisp);
  bigConfigStr = concatStringsSep "\n" (map (n: readFile (./elisp + ("/" + n))) srcFiles);
  bigConfig = toFile "emacsrc" bigConfigStr;
  # packages which aren't available in the nix-repositories, mostly because they're built-in, or built into another package
  blackList = [
    "cc-mode"
    "company-tern"
    "css-mode"
    "ede"
    "ediff"
    "flycheck-mix"
    "linum"
    "recentf"
    "semantic"
    "windmove"
  ];
  customConfig = runCommand "config.el" { } ''
    mkdir -p $out/share/emacs/site-lisp
    cp ${bigConfig} $out/share/emacs/site-lisp/default.el
  '';
  deps = runCommand "deps.nix" { } (''
    cat > $out << EOF
    config: epkgs: with (epkgs // epkgs.melpaPackages); [
    config
    use-package
    EOF

    cat ${bigConfig} | grep -o 'use-package [a-z0-9\-]*' | cut -d ' ' -f 2 >> $out
    echo ] >> $out
  '' + (concatStringsSep "\n" (map (n: "sed -i /${n}/d $out") blackList)));
  emacs = emacsWithPackages (import (deps.outPath) customConfig);
in
emacs
