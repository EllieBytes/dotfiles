#!/bin/sh

if [ $# -lt 3 ]; then
  echo "gen-host.sh: generates a config path for a host"
  echo "Read the docs to find out what these values are/do"
  echo "USAGE: gen-host.sh [system] [class] [name]"
fi

mkdir -p ./hosts/$1-$2/$3
echo "{ ... }:\n\n{ }" > ./hosts/$1-$2/$3/configuration.nix
