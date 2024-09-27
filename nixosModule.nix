{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  inherit (config) nixos services;
  inherit (lib)
    mkDefault
    mkOption
    types
    substring
    stringLength
    toUpper
    ;

  inherit (inputs.self) nixosModules homeModules;

  capitalizeString = s: toUpper (substring 0 1 s) + substring 1 (stringLength s) s;
in
{
  imports = [
    nixosModules.home-manager
    nixosModules.nixos-shell
  ];

  options = {
    nixos.hostName = mkOption {
      type = types.str;
      default = "nixos";
    };

    nixos.userName = mkOption {
      type = types.str;
      default = "nixos";
    };
  };

  config = {
    networking.hostName = nixos.hostName;

    users.users.default = {
      isNormalUser = true;
      name = nixos.userName;
      description = capitalizeString nixos.userName;

      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };

    users.defaultUserShell = pkgs.fish;

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    programs.fish = {
      enable = true;
      interactiveShellInit = mkDefault "set -g fish_greeting";
    };

    environment.systemPackages = [
      pkgs.nixd
      pkgs.nixfmt-rfc-style
    ];

    programs.nh = {
      enable = true;
      flake = /etc/nixos;
    };

    programs.mosh.enable = services.openssh.enable;

    time.timeZone = "Europe/Amsterdam";
    i18n.defaultLocale = "en_US.UTF-8";

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
      # "pipe-operators"
    ];

    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };
}
