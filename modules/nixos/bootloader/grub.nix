{ config
, lib
, pkgs
, myLib
, ...}:

myLib.registerModule "bootloader/grub" {
  options.bootloader.grub = {
    bootType = lib.mkOption {
      description = "Whether the system is EFI or MBR";
      type = lib.types.enum [ "efi" "mbr" ];
      default = "efi";
      example = "mbr";
    };

    device = lib.mkOption {
      description = "What device on which to install GRUB";
      type = lib.types.str;
      default = "nodev";
      example = "/dev/sda";
    };

    efiSysMountPoint = lib.mkOption {
      description = "The EFI system mount point";
      type = lib.types.str;
      default = "/boot";
      example = "/boot/efi";
    };
  };

  config.boot = 
  let
    cfg = config.bootloader.grub;
    isEFI = (if cfg.bootType == "efi" then true else false);
    isMBR = (if cfg.bootType == "mbt" then true else false);
  in
  {
    loader = {
      # Unload systemd-boot by default
      systemd-boot.enable = lib.mkDefault false;
      grub = {
        enable = lib.mkDefault true;    
        device = "${config.bootloader.grub.device}";
        useOSProber = lib.mkDefault true;  
        efiSupport = isEFI;
      };

      efi = {
        canTouchEfiVariables = isEFI;
        efiSysMountPoint = (if isEFI then cfg.efiSysMountPoint else null);
      };
    };
  };
}
