{ inputs
, nixpkgs
, lib
, flakeRoot
, flake
, debug ? true
, ... }:

{
  registerModule = (if debug then 
      (name: body: builtins.trace "Registering module ${name}" ({config.core.modulesLoaded = [ "${name}" ];}//body)) 
    else 
      (name: body: ({ config.core.modulesLoaded = [ "${name}" ]; }  // body)));
  registerProfile = (if debug then 
      (name: body: builtins.trace "Registering profile ${name}" ({config.core.profilesLoaded = [ "${name}" ];}//body)) 
    else 
      (name: body: ({ config.core.profilesLoaded = [ "${name}" ]; }  // body)));

  translateGitHubUrl = (url: ("https://github.com/" + (lib.strings.removePrefix "github:" url)));
}
