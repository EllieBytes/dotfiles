{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation rec {
  name = "dseg14-font";
  src = ./src;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp *.ttf $out/share/fonts/truetype
  '';
}
