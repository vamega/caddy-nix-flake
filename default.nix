{ pkgs ? (let
  inherit (builtins) fetchTree fromJSON readFile;
  inherit ((fromJSON (readFile ./flake.lock)).nodes) nixpkgs gomod2nix;
in import (fetchTree nixpkgs.locked) {
  overlays = [ (import "${fetchTree gomod2nix.locked}/overlay.nix") ];
}) }:

pkgs.buildGoApplication {
  pname = "caddy";
  version = "2.6.2";
  pwd = ./.;
  src = ./.;
  modules = ./gomod2nix.toml;
}
