{ config, lib, pkgs, ... }:

let
  mgmode = "POWER: (l)ock (e)xit (s)uspend (p)oweroff (h)ibernate (r)eboot";
  mod = config.wayland.windowManager.sway.config.modifier;

  lock = pkgs.writeShellScriptBin "swayfx-lock" ''
    ${pkgs.swaylock-effects}/bin/swaylock -Sekfl \
    --effect-blur 7x4 --effect-greyscale \
    --clock --indicator \
    --ring-color 8ec07c --separator-color 00000000 --inside-color 1d2021 --key-hl-color 689d6a --text-color fbf1c7 \
    --ring-clear-color fabd2f --inside-clear-color 1d2021 --text-clear-color fbf1c7 \
    --text-ver-color fbf1c7 --inside-ver-color 1d2021 --ring-ver-color 458588 \
    --ring-caps-lock-color fe8019 --text-caps-lock-color fbf1c7 \
    --ring-wrong-color cc241d --text-wrong-color fbf1c7 --inside-wrong-color 1d2021
  '';  
in
{
  home.packages = [ pkgs.jq pkgs.swaylock-effects pkgs.alacritty lock pkgs.swaybg ];

  wayland.windowManager.sway.config.modifier = "Mod4";
  wayland.windowManager.sway.config.menu = "${pkgs.vicinae}/bin/vicinae toggle";
  wayland.windowManager.sway.config.terminal = "${pkgs.vicinae}/bin/vicinae app launch --new Alacritty";

  wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
    "${mod}+n"              = "workspace number $(expr $(swaymsg -t get_workspaces | jq '. | length') + 1)";
    "${mod}+Shift+n"        = "move container to workspace number $(expr $(swaymsg -t get_workspaces | jq '. | length') + 1)";
    "${mod}+Shift+e"        = "mode \"${mgmode}\"";
    "${mod}+r"              = "mode \"resize\"";
    "${mod}+Shift+Return"   = "exec '${pkgs.vicinae}/bin/vicinae app launch Alacritty'";
    "XF86AudioLowerVolume"  = lib.mkDefault "exec wpctl set-volume @DEFAULT_SINK@ 5%-";
    "XF86AudioRaiseVolume"  = lib.mkDefault "exec wpctl set-volume @DEFAULT_SINK@ 5%+";
    "XF86AudioMute"         = lib.mkDefault "exec wpctl set-mute @DEFAULT_SINK@ toggle";
    "XF86MonBrightnessDown" = lib.mkDefault "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
    "XF86MonBrightnessUp"   = lib.mkDefault "exec ${pkgs.brightnessctl}/bin/brightnessctl set +5%";
  };

  wayland.windowManager.sway.config.modes = {
    resize = {
      "${config.wayland.windowManager.sway.config.left}"  = "resize shrink width  10px";
      "${config.wayland.windowManager.sway.config.down}"  = "resize grow   height 10px";
      "${config.wayland.windowManager.sway.config.up}"    = "resize shrink height 10px";
      "${config.wayland.windowManager.sway.config.right}" = "resize grow   width  10px";
      Left   = "resize shrink width  10px";
      Down   = "resize grow   height 10px";
      Up     = "resize shrink height 10px";
      Right  = "resize grow   width  10px";

      Return = "mode \"default\"";
      Escape = "mode \"default\"";
    };
   
    "${mgmode}" = {
      l = "mode \"default\"; exec '${lock}/bin/swayfx-lock'";
      e = "exit";
      s = "mode \"default\"; exec 'systemctl suspend'";
      p = "exec 'systemctl poweroff'";
      h = "mode \"default\"; exec 'systemctl hibernate'";
      r = "exec 'systemctl reboot'";

      Escape = "mode \"default\"";
      Return = "mode \"default\"";
    };
  };
}
