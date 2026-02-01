final: prev:

{
  dseg-weather        = prev.callPackage ../packages/dseg-weather/default.nix {};
  dseg14-classic      = prev.callPackage ../packages/dseg14-classic/default.nix {};
  dseg14-classic-mini = prev.callPackage ../packages/dseg14-classic-mini/default.nix {};
  dseg14-modern       = prev.callPackage ../packages/dseg14-modern/default.nix {};
  dseg14-modern-mini  = prev.callPackage ../packages/dseg14-modern-mini/default.nix {};
  dseg7-7seggchan     = prev.callPackage ../packages/dseg7-7seggchan/default.nix {};
  dseg7-classic       = prev.callPackage ../packages/dseg7-classic/default.nix {};
  dseg7-classic-mini  = prev.callPackage ../packages/dseg7-classic-mini/default.nix {};
  dseg7-modern        = prev.callPackage ../packages/dseg7-modern/default.nix {};
  dseg7-modern-mini   = prev.callPackage ../packages/dseg7-modern-mini/default.nix {};

  dseg7-full = prev.buildEnv {
    name = "dseg7-full";
    paths = [
      final.dseg7-classic
      final.dseg7-classic-mini
      final.dseg7-modern
      final.dseg7-modern-mini
    ];
  };

  dseg14-full = prev.buildEnv {
    name = "dseg14-full";
    paths = [
      final.dseg14-classic
      final.dseg14-classic-mini
      final.dseg14-modern
      final.dseg14-modern-mini
    ];
  };
}
