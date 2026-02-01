{ lib
, flakeRoot
, ... }:

{
  profileAt = (resolver: /${flakeRoot}/profiles/${resolver}.nix);
  moduleAt = (resolver: /${flakeRoot}/modules/nixos/${resolver}.nix);
  homeModuleAt = (resolver: /${flakeRoot}/modules/home/${resolver}.nix);
}
