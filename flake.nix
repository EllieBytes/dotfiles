{
  inputs = {
    # Core
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Utils

    # Extras
    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nvim-config.url = "github:EllieBytes/nvim-config";
  };

  outputs = inputs@{ self, flake-parts, nixpkgs, home-manager, ... }: 
    flake-parts.lib.mkFlake { inherit inputs; } (top@{ config, withSystem, moduleWithSystem, ... }: 
    let
      lib = import ./lib {
        inherit inputs nixpkgs;
        lib = nixpkgs.lib;
        flakeRoot = ./.;
        flake = self;
      };
    in
    {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      flake = {
        hosts = {
          lenowo = lib.host.mkHost {
            system = "x86_64-linux";
            name = "lenowo";
            class = "laptop";
            profiles = [ "base" "laptop" ];
            stateVersion = "25.11";
            modules = [ 
              "bootloader/grub" 
              "services/tuigreet"
              "gaming/steam"
              "tools/cybersecurity"
            ];
            resolvedModules = [ inputs.minegrub-theme.nixosModules.default ];
            homeUsers = [ "ellie" ];
            homeModules = [ 
              "workflows/engineering" "workflows/software" 
              "programs/vicinae" 
            ];
            homeModulesResolved = [ inputs.zen-browser.homeModules.beta ];
          };
        };

        nixosConfigurations = lib.host.generateHostOutputFields self.hosts; 
      };

      perSystem = { config, pkgs, ... }: {};
    });
}
