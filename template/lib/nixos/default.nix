{ inputs
, nixpkgs
, lib
, flakeRoot
, flake
, ... }:

{
  registerModule = (name: body: ({ config.core.modulesLoaded = [ "${name}" ]; }  // body));
  registerProfile = (name: body: ({ config.core.profilesLoaded = [ "${name}" ]; } // body));
}
