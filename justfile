default:
  @just --list

deploy:
  sudo nixos-rebuild switch --flake .

debug:
  sudo nixos-rebuild switch --flake . --show-trace --verbose

history:
  nix profile history --profile /nix/var/nix/profiles/system

wipe-history:
  sudo nix profile wipe-history --older-than 7d --profile /nix/var/nix/profiles/system

update:
  nix flake update
