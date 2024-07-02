{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.fish;

  programs.fish = {
    enable = true;
    interactiveShellInit = "set -g fish_greeting";
  };
}

