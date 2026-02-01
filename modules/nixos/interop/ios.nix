{ myLib, pkgs, ... }:

myLib.registerModule "interop/ios" {
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  environment.systempackages = with pkgs; [
    libimobiledevice libimobiledevice-glue ifuse idevicerestore ideviceinstaller
  ];
}
