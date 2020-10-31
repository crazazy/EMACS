{ pkgs ? import <nixpkgs> { } }:
let
  inherit (pkgs) runCommand emacsWithPackages;
  inherit (builtins) attrNames concatStringsSep readDir foldl' readFile toFile;
  srcFiles = attrNames (readDir ./elisp);
  bigConfigStr = concatStringsSep "\n" (map (n: readFile (./elisp + ("/" + n))) srcFiles);
  bigConfig = toFile "emacsrc" bigConfigStr;
  customConfig = runCommand "config.el" { } ''
    mkdir -p $out/share/emacs/site-lisp
    cp ${bigConfig} $out/share/emacs/site-lisp/default.el
  '';
  deps = runCommand "deps.nix" { } ''
    cat > $out << EOF
    config: epkgs: with epkgs; [ config ] ++ map (e: builtins.getAttr e epkgs) (builtins.filter (v: builtins.hasAttr v epkgs)[
    "use-package"
    EOF

    cat ${bigConfig} | grep -o 'use-package [a-z0-9\-]*' | sed -e 's/[a-z0-9\-]*$/"\0"/g' | cut -d ' ' -f 2 >> $out
    echo "])" >> $out
  '';
  emacs = emacsWithPackages (import (deps.outPath) customConfig);
in
emacs
