{ config, pkgs, lib, ... }:

{
  options.programs.ranger = {
    extraRifles = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [];
      example = [ { condition = ""; command = ""; } ];
    };
  };

  config.programs.ranger = {
    enable = lib.mkDefault true;

    rifle = lib.mkDefault [
      
    ] ++ config.programs.ranger.extraRifles;
  };
}
