#!/usr/bin/env bash
DIR=`cd $(dirname "${BASH_SOURCE[0]}") && pwd`
TIMSTAMP=`date | tr -s " " "-"`

if [[ ! -n "$1" ]];
then
  echo "System-Name argument missing. Please use the name of a sub-directory under the 'config/systems' folder."
  exit 1
fi
  
CONF="$DIR/config/systems/$1/configuration.nix"

if [[ ! -e "$CONF" ]];
then
  echo "'configuration.nix' does not exists in $CONF"
  exit 1
fi

echo "Building configuration in $CONF"

if [[ `uname` == "Darwin" ]];
then
  mkdir -p $HOME/.nixpkgs
  sudo ln -sf $CONF $HOME/.nixpkgs/darwin-configuration.nix
  darwin-rebuild switch
fi

# TODO: Need to differentiate between other linux and nixos
if [[ `uname` == "Linux" ]];
then
  sudo cp -P /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak_${TIMSTAMP}
  sudo ln -sf $CONF /etc/nixos/configuration.nix
  sudo nixos-rebuild switch
fi