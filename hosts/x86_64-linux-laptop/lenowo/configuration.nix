{ lib, pkgs, ... }:

{
  users.users.ellie = {
    isNormalUser = true;
    description = "Ellie Johnston";
    extraGroups = [ "wheel" "libvirtd" "video" "nix" ];
  };

  boot.loader.grub.minegrub-theme = {
    enable = true;
    background = "background_options/1.21.6 - [Chase the Skies].png";
    boot-options-count = 5;
  };

  services.tuigreet.command = "${pkgs.swayfx}/bin/swayfx";

  security.pam.services.swaylock = lib.mkDefault {};

  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
  };

  system.stateVersion = "25.11";

  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];
}
