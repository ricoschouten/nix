{
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (config) networking;
  inherit (lib) mkIf mkDefault mkAliasOptionModule;
  inherit (inputs) home-manager;
  inherit (inputs.self) homeModules;
in
{
  imports = [
    home-manager.nixosModules.home-manager

    (mkAliasOptionModule [ "user" ] [
      "users"
      "users"
      "default"
    ])

    (mkAliasOptionModule [ "root" ] [
      "users"
      "users"
      "root"
    ])

    (mkAliasOptionModule [ "home" ] [
      "home-manager"
      "users"
      "default"
      "home"
    ])
  ];

  users.users = {
    default = {
      name = mkDefault "nixos";
      isNormalUser = true;
      extraGroups = [
        (mkIf networking.networkmanager.enable "networkmanager")
        "wheel"
      ];
    };
  };

  home-manager.users = {
    default = mkDefault { };
  };

  home-manager = {
    useGlobalPkgs = mkDefault true;
    useUserPackages = mkDefault true;
    sharedModules = [ homeModules.default ];
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
