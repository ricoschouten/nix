{ lib, config, ... }:

let
  inherit (lib) mkIf mkDefault mkOverride;
  inherit (config) programs;
in
{
  config = mkIf programs.fish.enable {
    programs.fish = {
      interactiveShellInit = "set -g fish_greeting";
    };

    users.defaultUserShell = mkOverride 500 programs.fish.package;
  };
}
