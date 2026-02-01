# Dependency for every module, profile, and host.
# Defines a lot of data to be analyzed at build time
# Allows for advanced decision making
# INFO: should be included when you add syscore to your module list

{ config
, lib
, pkgs
, class
, name
, flakePath
, allowUnfree
, root
, rootUrl
, ... }:


let
  end-rebuild-self = pkgs.writeShellScriptBin "end-rebuild-self" ''
    echo "Rebuilding from github upstream"
    sudo nixos-rebuild switch --flake $END_PREFIX#$END_SYSNAME
  '';

  end-rebuild-host = pkgs.writeShellScriptBin "end-rebuild-host" ''
    sudo nixos-rebuild switch --flake $END_PREFIX#$1
  '';
in builtins.trace "Constructing system ${name} at ${root}" {
  config.assertions = [
    {
      assertion = lib.versionAtLeast config.system.stateVersion "25.11";
      message = ''
        This config must be run on at least NixOS 25.11 (Xanthusia)
        You are currently on ${config.system.stateVersion}
      '';
    }
  ];

  config.nix.settings.experimental-features = [ "nix-command" "flakes" ];

  options.core = {
    minimumStateVersion = lib.mkOption {
      description = "The minimum NixOS version supported by the Core module";
      type = lib.types.str;
      readOnly = true;
      default = "25.11";
    };

    modulesLoaded = lib.mkOption {
      description = "List of module names currently loaded by this config";
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };

    profilesLoaded = lib.mkOption {
      description = "List of profiles composing the current system config";
      type = lib.types.listOf lib.types.str;
      default = [ "core" ];
    };
  };

  config.environment.variables = {
    END_MODULES = config.core.modulesLoaded;
    END_PROFILES = config.core.profilesLoaded;
    END_CLASS = class;
    END_SYSNAME = name;
    END_PREFIX = rootUrl;
  };

  config.environment.systemPackages = [
    end-rebuild-self end-rebuild-host
  ]; 

  config.networking.hostName = lib.mkDefault name;
  config.nixpkgs.config.allowUnfree = lib.mkDefault allowUnfree;
}
