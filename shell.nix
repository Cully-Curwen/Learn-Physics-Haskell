{ pkgs ? import <nixpkgs> {} }:

let
  # Specify GHC version
  haskellPackages = pkgs.haskellPackages;
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    # Core Haskell tools
    haskellPackages.ghc
    haskellPackages.cabal-install
    haskellPackages.haskell-language-server
    haskellPackages.hoogle   # Documentation lookup
  ];
}
