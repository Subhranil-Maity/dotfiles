#!/usr/bin/env bash

nix flake update
sudo nixos-rebuild switch --flake .
home-manager switch --flake .