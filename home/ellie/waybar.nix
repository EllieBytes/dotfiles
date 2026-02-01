{ config, lib, pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.dseg7-full
    pkgs.dseg14-full
  ];

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    systemd.enable = true; 

    settings = {
      mainBar = {
        spacing = 0;
        layer = "top";
        position = "top";
        height = 20;
        output = [
          "eDP-1"
          "HDMI-A-1"
        ];

        modules-left   = [ "image" "custom/bracket1" "sway/workspaces" "custom/bracket2" "sway/scratchpad" ];
        modules-center = [ "sway/mode" "custom/weather" ];
        modules-right  = [ "battery" "custom/bracket1" "network" "memory" "cpu" "backlight" "wireplumber" "tray" "custom/bracket2" "clock" ];

        image = {
          path = "${pkgs.nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png";
          size = 20;
        };

        "custom/bracket1" = {
          format = "(";
        };

        "custom/bracket2" = {
          format = ")";
        };

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };

        "sway/scratchpad" = {
          format = "{icon} {count}";
          format-icons = [ "" "󰖲" ];
        };

        battery = {
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };

          format = "{icon} {capacity}%";
          format-icons = [ "󱊡" "󱊢" "󱊣"  ];
        };

        network = {
          interface = "*";
          format = "󰢿";
          format-wifi = "{icon} ({signalStrength}%)";
          format-ethernet = "  {ipaddr}";
          format-disconnected = "";
          format-disabled = "󰞃";
          format-icons = [
            "󰢿" "󰢼" "󰢽" "󰢾"
          ];
        };

        memory = {
          interval = 10;
          format = " {icon}";
          format-icons = [ "󰡳" "󰡵" "󰊚" "󰡴" ];
        };

        cpu = {
          interval = 10;
          format = " {icon}";
          format-icons = [ "󰡳" "󰡵" "󰊚" "󰡴" ];
        };

        backlight = {
          interval = 2;
          format = "{icon}";
          format-icons = [ "󰃚" "󰃛" "󰃜" "󰃝" "󰃞" "󰃟" "󰃠" ];
        };

        wireplumber = {
          format = "{icon}";
          format-muted = "󰝟";
          format-icons = [ "󰕿" "󰖀" "󰕾" ];
        };

        clock = {
          interval = 1;
          format = "{:%H:%M:%S}";
        };
      };
    };

    style = builtins.readFile ./res/stylesheets/waybar.css;
  };
}
