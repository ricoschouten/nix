{
  lib,
  config,
  inputs,
  ...
}:

let
  inherit (lib) mkIf mkDefault mkAliasOptionModule;
  inherit (config) networking;
  inherit (inputs) self home-manager;
  inherit (inputs.self) nixosModules homeModules;
in
{
  imports = [
    home-manager.nixosModules.home-manager

    (mkAliasOptionModule [ "user" ] [
      "users"
      "users"
      "default"
    ])

    (import "${self}/configuration.nix")
    (import "${self}/hardware-configuration.nix")

    nixosModules.fish
    nixosModules.gnome
  ];

  users.users.default = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      (mkIf networking.networkmanager.enable "networkmanager")
    ];
  };

  home-manager = {
    useGlobalPkgs = mkDefault true;
    useUserPackages = mkDefault true;
    sharedModules = [ homeModules.default ];

    users.default = import "${self}/home.nix";
  };

  nixpkgs.config.allowUnfree = mkDefault true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
