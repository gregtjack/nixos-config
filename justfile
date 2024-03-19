# NixOS related commands

default:
  just --list

deploy:
  sudo nixos-rebuild switch --flake .

debug:
  sudo nixos-rebuild switch --flake . --show-trace --verbose

update:
  nix flake update

show:
  nix flake show
