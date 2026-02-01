{ myLib, lib, ... }:

myLib.registerModule "hardware/pipewire" {
  services.pipewire = {
    enable = lib.mkDefault true;
    pipewire.enable = lib.mkDefault true;
    audio.enable = lib.mkDefault true;
  };
}
