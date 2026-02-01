{
  imports = [
    ./autostart.nix
    ./keybindings.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    xwayland = true;
    systemd.enable = true;
  };
}
