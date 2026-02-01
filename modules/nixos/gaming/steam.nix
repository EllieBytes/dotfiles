{ myLib, lib, pkgs, ... }:

myLib.registerModule "gaming/steam" {
  config.programs.steam = {
    enable = lib.mkDefault true;
    remotePlay.openFirewall = lib.mkDefault true;
    dedicatedServer.openFirewall = lib.mkDefault true;
    localNetworkGameTransfers.openFirewall = lib.mkDefault true;
  };
}
