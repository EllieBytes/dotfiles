{ inputs
, nixpkgs
, lib
, flakeRoot
, flake
, nixosLib
, ... }:

{
  registerModule = (name: body: ({ config.core.modulesLoaded = [ "${name}" ]; } // body));
}
