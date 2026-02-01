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

  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    dseg14-full dseg7-full nerd-fonts.fira-code
  ];

  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
  };

  system.stateVersion = "25.11";

  networking.networkmanager.dns = "none";
  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];
}
