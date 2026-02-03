{ config, lib, pkgs, ... }:

let
  mkWindowColorSet = (border: background: text: indicator: childBorder: {
    inherit border background text indicator childBorder;
  });
in
{
  wayland.windowManager.sway = {
    config.window = {
      border   = lib.mkDefault 2;
      titlebar = lib.mkDefault false;
    };

    config.floating = {
      border   = lib.mkDefault 2;
    };

    config.gaps = {
      inner = lib.mkDefault 3;
      outer = lib.mkDefault 3;
      smartBorders = lib.mkDefault "off";
      smartGaps    = lib.mkDefault false;
    };

    config.colors = {
      background      = "#1d2021";
      focused         = mkWindowColorSet "#b16286" "#b16286" "#fbf1c7" "#d3869b" "#b16286";
      focusedInactive = mkWindowColorSet "#665c54" "#665c54" "#fbf1c7" "#928374" "#665c54";
      placeholder     = mkWindowColorSet "#000000" "#0c0c0c" "#ffffff" "#000000" "#0c0c0c";
      unfocused       = mkWindowColorSet "#504945" "#504945" "#fbf1c7" "#665c54" "#504945";
      urgent          = mkWindowColorSet "#d65d0e" "#d65d0e" "#fbf1c7" "#fe8019" "#d65d0e";
    };

    extraConfig = ''
      corner_radius 5
      blur enable
      blur_xray disable
      blur_radius 3
      blur_passes 1
    '';
  };
}
