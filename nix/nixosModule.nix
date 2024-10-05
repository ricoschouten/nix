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
    inputs.catppuccin.nixosModules.catppuccin

    nixosModules.user
    nixosModules.home
    nixosModules.fish
    nixosModules.gnome
    nixosModules.hyprland
    nixosModules.vm
  ];

  catppuccin.enable = true;

  environment.systemPackages = [
    pkgs.coreutils
    pkgs.git
    # pkgs.nixd
    # pkgs.nixfmt-rfc-style
  ];

  nixpkgs.config.allowUnfree = mkDefault true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    # "pipe-operators"
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
