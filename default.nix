{ pkgs ? import <nixpkgs> { }, configDir ? ./elisp}:
let
  inherit (pkgs) runCommand emacsWithPackages;
  inherit (builtins) attrNames concatStringsSep readDir foldl' pathExists readFile toFile;
  srcFiles = attrNames (readDir configDir);
  hasBase = pathExists (configDir + "/_base.el");
  bigConfigStr = (if hasBase then "" else (readFile ./elisp/_base.el)) + (concatStringsSep "\n" (map (n: readFile (configDir + ("/" + n))) srcFiles));
  bigConfig = toFile "emacsrc" bigConfigStr;
  customConfig = runCommand "config.el" { } ''
    mkdir -p $out/share/emacs/site-lisp
    cp ${bigConfig} $out/share/emacs/site-lisp/default.el
  '';
  deps = runCommand "deps.nix" { } ''
    cat > $out << EOF
    config: epkgs: [ config ] ++ map (e: builtins.getAttr e epkgs) (builtins.filter (v: builtins.hasAttr v epkgs) [
    "use-package"
    EOF

    cat ${bigConfig} | grep -o 'use-package [a-z0-9\-]*' | sed -e 's/[a-z0-9\-]*$/"\0"/g' | cut -d ' ' -f 2 >> $out
    echo "])" >> $out
  '';
  emacs = emacsWithPackages (import (deps.outPath) customConfig);
in
emacs
