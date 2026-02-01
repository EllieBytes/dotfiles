{ config, lib, ... }:

{
  options.modules.services.mpd.dataPath = lib.mkOption {
    description = "Directory for mpd to search for music";
    
  };
}
