{
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (config) networking wsl;
  inherit (lib) mkIf mkDefault mkAliasOptionModule;
  inherit (inputs) home-manager;
  inherit (inputs.self) homeModules;

  mkAliasOptionModule' =
    path:
    mkAliasOptionModule path [
      "home-manager"
      "users"
      "default"
    ];
in
{
  imports = [
    home-manager.nixosModules.home-manager
    (mkAliasOptionModule' [ "home" ])
  ];

  config = {
    home-manager = {
      useGlobalPkgs = mkDefault true;
      useUserPackages = mkDefault true;
      sharedModules = [ homeModules.default ];
      extraSpecialArgs = {
        inherit inputs;
      };

      users.default = mkDefault { };
    };
  };
}
