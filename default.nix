{ lib, inputs, ... }:

let
  inherit (lib) systems;
in
lib.mkFlake ./. {
  inherit lib;

  functor = _: lib.mkFlake;
  templates = import ./templates;
  checks.statix = pkgs: "${pkgs.statix}/bin/statix check";
  outputs.tests = import ./tests inputs;

  systems = systems.flakeExposed;

  devShells.test = { };
}
