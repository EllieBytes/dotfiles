{ inputs
, nixpkgs
, lib
, flakeRoot
, flake
, rootUrl ? "github:EllieBytes/dotfiles"
, ... }:

let
  # Flake utilities
  flakeLib = import ./flake {
    inherit lib flakeRoot;
  };

  # Host utilities
  hostLib = import ./hosts {
    inherit inputs nixpkgs lib flakeRoot flake flakeLib nixosLib homeLib rootUrl;
  };

  # NixOS utilities
  nixosLib = import ./nixos {
    inherit inputs nixpkgs lib flakeRoot flake;
  };

  # Home manager utilities
  homeLib = import ./home {
    inherit inputs nixpkgs lib flakeRoot flake nixosLib;
  };
in {
  flake = flakeLib;
  host = hostLib;
  nixos = nixosLib;
  home = homeLib;
}
