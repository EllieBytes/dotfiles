#TODO: Refactor for better configuration
{ lib, myLib, ... }:

myLib.registerModule "bootloader/systemd-boot" {
  boot.loader.systemd-boot.enable = lib.mkDefault true;
}
