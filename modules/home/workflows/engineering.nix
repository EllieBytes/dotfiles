{ config, lib, pkgs, myLib, ... }:

{
  home.packages = with pkgs; [
    orca-slicer freecad arduino arduino-ide arduino-language-server
    arduino-cli
  ];
}
