{ config
, lib
, pkgs
, myLib
, ...}:

myLib.registerProfile "base" {
  options.profiles.base = {
    locale = lib.mkOption {
      description = "The locale to use";
      type = lib.types.str;
      default = "en_US.UTF-8";
    };
    
    timeZone = lib.mkOption {
      description = "The time zone to use";
      type = lib.types.str;
      default = "America/New_York";
    };
  };

  config.i18n = {
    defaultLocale = "${config.profiles.base.locale}";
    extraLocaleSettings = {
      LC_ADDRESS        = "${config.profiles.base.locale}";
      LC_IDENTIFICATION = "${config.profiles.base.locale}";
      LC_MEASUREMENT    = "${config.profiles.base.locale}";
      LC_MONETARY       = "${config.profiles.base.locale}";
      LC_NAME           = "${config.profiles.base.locale}";
      LC_NUMERIC        = "${config.profiles.base.locale}";
      LC_PAPER          = "${config.profiles.base.locale}";
      LC_TELEPHONE      = "${config.profiles.base.locale}";
      LC_TIME           = "${config.profiles.base.locale}";
    };
  };
  
  config.networking.firewall.enable = lib.mkDefault true;
 
  config.nix.gc = {
    automatic = true;
    persistent = true;
    dates = "weekly";
    options = "--delete-older-than=7d";
  };

  config.environment.systemPackages = with pkgs; [ sl ];
}
