{
  imports = [
    ./autostart.nix
    ./keybindings.nix
    ./theme.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    xwayland = true;
    systemd.enable = true;
  };
}
