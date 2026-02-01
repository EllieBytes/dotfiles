{ pkgs, lib, ... }:

{
  programs.vicinae = {
    enable = lib.mkDefault true;
    package = lib.mkDefault pkgs.vicinae;
    systemd = {
      enable = lib.mkDefault true;
      target = lib.mkDefault "graphical-session.target";
    };
  };
}
