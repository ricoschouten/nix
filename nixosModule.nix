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
    nixosModules.system
    nixosModules.users
    nixosModules.wsl
    nixosModules.vm
  ];

  networking.hostName = mkDefault "nixos";
  networking.useDHCP = mkDefault true;

  boot.loader.grub.enable = mkDefault true;

  services.openssh.enable = mkDefault true;

  programs.mosh.enable = mkDefault true;

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
