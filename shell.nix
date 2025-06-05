{ pkgs ? import <nixpkgs> {} }:

let
  # Specify GHC version
  haskellPackages = pkgs.haskellPackages;
in
haskellPackages.shellFor {
  packages = p: [ (p.callCabal2nix "Learn-Physics-Haskell" ./. {}) ];

  withHoogle = true;

  nativeBuildInputs = with haskellPackages; [
    cabal-install
    haskell-language-server
  ];

  buildInputs = with pkgs; [
    gnuplot
  ];
}
