{
  inputs = {
    # Core
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, flake-parts, nixpkgs, ... }: 
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
        hosts = { /* Define hosts here */ };

        nixosConfigurations = lib.host.generateHostOutputFields self.hosts; 
      };

      perSystem = { config, pkgs, ... }: {};
    });
}
