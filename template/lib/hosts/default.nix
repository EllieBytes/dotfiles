{ flakeLib
, nixpkgs
, flakeRoot
, flake
, inputs
, nixosLib
, ...}:

let
  syscore = [
    /${flakeRoot}/profiles/core.nix
  ];

  homecore = [
    /${flakeRoot}/modules/home/core.nix
  ];

  mkHost = {
    name, 
    system, 
    class ? "generic",
    root ? /${flakeRoot}/hosts/${system}-${class}/${name},
    stateVersion ? "25.11",
    profiles ? [],
    resolvedProfiles ? [],
    modules ? [],
    resolvedModules ? [],
    extraSpecialArgs ? {},
    useHomeManager ? true,
    homeModules ? [],
    homeModulesResolved ? [],
    homeUsers ? [],
    extraExtraSpecialArgs ? {},
    allowUnfree ? false,
    useSysCore ? true,
    useOverlays ? true,
    useLibExtend ? true
  }: {
    inherit name system class root stateVersion profiles resolvedProfiles;
    inherit modules resolvedModules extraSpecialArgs useHomeManager;
    inherit homeModules homeUsers extraExtraSpecialArgs allowUnfree useSysCore;
    inherit useOverlays useLibExtend homeModulesResolved;
  };

  mkHost' = {
    # Base definition (REQUIRED)
    name,
    system,
    class ? "generic",
    root ? /${flakeRoot}/hosts/${system}-${class}/${name},
    stateVersion ? "25.11", 
    profiles ? [],         # These are profiles that will be resolved
    resolvedProfiles ? [], # These are paths to profiles
    
    # NixOS Definition (OPTIONAL)
    modules ?  [],
    resolvedModules ? [],
    extraSpecialArgs ? {},

    # Home Manager Definition (DOUBLE OPTIONAL)
    useHomeManager ? true,
    homeModules ? [],
    homeModulesResolved ? [],
    homeUsers   ? [],
    extraExtraSpecialArgs ? {},

    # Extras
    allowUnfree ? false,

    # Dangerous stuff, don't change their values unless you KNOW what you're doing
    useSysCore ? true, # Will break functionality with native modules, only use if reimplementing syscores
    useOverlays ? true, # Breaks certain functionality
    useLibExtend ? true # Breaks other functions
  }: 
  let
    pkgs' = (if useOverlays then 
      import nixpkgs { inherit system allowUnfree; overlays = [ (import /${flakeRoot}/overlay) ]; }  
    else 
      import nixpkgs { inherit system allowUnfree; }
    );
    myLib = nixosLib;
  in
  nixpkgs.lib.nixosSystem {
    inherit system;

    specialArgs = {
      inherit inputs allowUnfree stateVersion system class root name flake;
      flakePath = flakeRoot;
    }
    // (if useLibExtend then { inherit myLib; } else {})
    // extraSpecialArgs;
  
    modules = 
      (if useSysCore then syscore else builtins.warn "Disabling the syscore module set is dangerous, here be dragons..." [])
      ++ (builtins.map (p: flakeLib.profileAt p) profiles)
      ++ resolvedProfiles
      ++ (builtins.map (m: flakeLib.moduleAt m) modules)
      ++ resolvedModules
      ++ [      
        (if useHomeManager then inputs.home-manager.nixosModules.home-manager else {})
        (if useHomeManager then {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users = (if homeUsers != [] then pkgs'.lib.genAttrs homeUsers (user: {
            imports = (if useSysCore then homecore else []) 
            ++ homeModulesResolved
            ++ (builtins.map (m: flakeLib.homeModuleAt m) homeModules)
            ++ [ 
              /${flakeRoot}/home/${user}/home.nix 
            ];

            home.stateVersion = 25.11;
          }) else builtins.warn "Home manager is enabled but there are no users" {});
          home-manager.extraSpecialArgs = {
            inherit stateVersion;
            modules =
            (if useSysCore then homecore else [])
            ++ homeModules;
          } // extraExtraSpecialArgs;
        } else builtins.trace "Not running under home manager, relavent fields unaccounted for" {})
        /${root}/configuration.nix
        /${root}/hardware-configuration.nix
      ];
  };

  generateHostOutputFields = (hosts: (builtins.mapAttrs (name: value: mkHost' value) hosts));
in { 
  inherit mkHost mkHost' generateHostOutputFields;
}
