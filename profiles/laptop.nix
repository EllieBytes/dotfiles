{ config, lib, pkgs, myLib, ... }:

myLib.registerProfile "laptop" {
  options.laptop = {
    features = lib.mkOption {
      description = "List of features onboard the laptop";
      type = lib.types.listOf (lib.types.enum [ "bluetooth" "fingerprint-reader" ]);
      default = [ "bluetooth" "fingerprint-reader" ];
      example = [ "bluetooth" ];
    };

    fingerprintDriverPackage = lib.mkOption {
      description = "Fingerprint reader driver to use";
      type = lib.types.package;
      default = pkgs.libfprint-2-tod1-goodix;
      example = pkgs.libfprint-2-tod1-goodix-550a;
    };
  };

  config.networking.networkmanager.enable = lib.mkDefault true;
  config.hardware.bluetooth.enable = lib.mkDefault (builtins.any (x: x == "bluetooth") config.laptop.features);
  config.services.power-profiles-daemon.enable = lib.mkDefault true;
  config.services.fprintd.enable = lib.mkDefault (builtins.any (x: x == "fingerprint-reader") config.laptop.features);
  config.services.fprintd.tod.enable = lib.mkDefault (builtins.any (x: x == "fingerprint-reader") config.laptop.features);
  config.services.fprintd.tod.driver = lib.mkDefault config.laptop.fingerprintDriverPackage;

  config.environment.systemPackages = (if builtins.any (x: x == "bluetooth") config.laptop.features then [ pkgs.blueman ] else []);
}
