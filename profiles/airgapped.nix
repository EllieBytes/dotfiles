#WARNING: THIS MODULE FORCES SHUTOFF OF ALL WIRELESS NETWORKING, THIS CAN'T BE OVERRIDEN BY OTHER PROFILES/MODULES!
# This cannot be reversed without some sort of wired connectivity/rollback so be very very careful
{ myLib, lib, ... }:

builtins.warn "airgapped profile loaded, all wireless networking capability to be disabled after this build" (myLib.registerProfile "airgapped" {
  boot.blacklistedKernelModules = [ "iwlwifi" "ath10k_pci" ];
  systemd.services.wpa_supplicant.wantedBy = lib.mkForce [];
  networking.networkmanager.wifi.backend = lib.mkForce "no-op";
  hardware.bluetooth.enable = lib.mkForce false;
  # Now your WiFi chip is a vestigial organ, better have thought this through...
})
