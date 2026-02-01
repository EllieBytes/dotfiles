{ pkgs, ... }:

let
  execOnce = (cmd: { always = false; command = cmd; });
  exec = (cmd: { always = true; command = cmd; });

  bgPath = ../res/wallpapers;
  randomPaper = pkgs.writeShellScriptBin "random-wallpaper" ''
    ${pkgs.swaybg}/bin/swaybg -i $(find ${bgPath} -type f | shuf -n1) -m fill
  '';
in
{
  home.packages = [ randomPaper pkgs.swaybg ];

  wayland.windowManager.sway.config.startup = [
    (exec "${pkgs.vicinae}/bin/vicinae server --replace")
    (exec "${randomPaper}/bin/random-wallpaper")
  ];
}
