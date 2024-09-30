{
  lib,
  pkgs,
  inputs,
  ...
}:

let
  inherit (lib) mkDefault;
  inherit (inputs.self) nixosModules;
in
{
  imports = [
    nixosModules.users
    nixosModules.wsl
    nixosModules.vm
  ];

  users.defaultUserShell = pkgs.fish;

  programs.fish = {
    enable = true;
    interactiveShellInit = mkDefault "set -g fish_greeting";
  };

  environment.systemPackages = [
    pkgs.coreutils
    pkgs.git
    pkgs.nixd
    pkgs.nixfmt-rfc-style
  ];

  time.timeZone = mkDefault "Europe/Amsterdam";
  i18n.defaultLocale = mkDefault "en_US.UTF-8";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    # "pipe-operators"
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
