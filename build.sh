#!/usr/bin/env bash

set -e
pushd ~/nixos-config
hx
alejandra . &>/dev/null
git diff -U0 *.nix
echo "NixOS Rebuilding..."
sudo nixos-rebuild switch &>nixos-switch.log || (
  cat nxios-switch.log | rg error && false
)
gen=$(nixos-rebuild list-generations | rg current)
git commit -am "$gen"
popd
