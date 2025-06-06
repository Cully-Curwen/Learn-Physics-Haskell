{ pkgs ? import <nixpkgs> {} }:

let
  # Specify GHC version
  haskellPackages = pkgs.haskellPackages;
in
haskellPackages.shellFor {
  packages = p: [
    (p.callCabal2nix "Learn-Physics-Haskell" ./. {})
    p.gloss # from src/Chapter13.cabal, can't use callCabal2nix as not-gloss is broken in haskellPackages
  ];

  withHoogle = true;

  nativeBuildInputs = with haskellPackages; [
    cabal-install
    haskell-language-server
  ];
}
