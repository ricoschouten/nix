{ lib, inputs, ... }:

let
  inherit (lib) mkDefault mkAliasOptionModule;
  inherit (inputs.self) homeModules;
  inherit (inputs.home-manager.nixosModules) home-manager;

  mkOptionAlias =
    path:
    let
      from = [ "nixos" ] ++ path;
      to = [
        "home-manager"
        "users"
        "default"
      ] ++ path;
    in
    mkAliasOptionModule from to;
in
{
  imports = [
    home-manager
    (mkOptionAlias [ "home" ])
  ];

  config = mkDefault {
    home-manager.extraSpecialArgs = {
      inherit inputs;
    };

    home-manager.users.default = {
      imports = [ homeModules.default ];
    };
  };
}
