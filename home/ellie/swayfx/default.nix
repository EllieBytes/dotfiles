{
  imports = [
    ./autostart.nix
    ./keybindings.nix
    ./theme.nix
    ./xdg.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    xwayland = true;
    systemd.enable = true;
    config.bars = [];
  };
}
