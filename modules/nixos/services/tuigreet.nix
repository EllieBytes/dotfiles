{ myLib, lib, pkgs, config, ... }:

myLib.registerModule "services/tuigreet" {
  options.services.tuigreet.command = lib.mkOption {
    description = "The command to run when the user logs in.";
    type = lib.types.str;

    default = "${pkgs.bash}/bin/bash";
    example = "${pkgs.swayfx}/bin/swayfx";
  };

  config.services.greetd = {
    enable = true;
    settings.default_session = {
      user = "greeter";
      command = "${pkgs.tuigreet}/bin/tuigreet --remember --user-menu --asterisks --cmd ${config.services.tuigreet.command}";
    };
  };

  config.environment.systemPackages = with pkgs; [ tuigreet ];
}
