{
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (config) networking wsl;
  inherit (lib) mkIf mkDefault mkAliasOptionModule;
  inherit (inputs) nixos-wsl;
  inherit (inputs.self) homeModules;

  mkAliasOptionModule' =
    path:
    mkAliasOptionModule path [
      "users"
      "users"
      "default"
    ];
in
{
  imports = [
    nixos-wsl.nixosModules.default
    (mkAliasOptionModule' [ "user" ])
  ];

  config = {
    users.users.default = {
      name = mkDefault "nixos" // mkIf wsl.enable wsl.defaultUser;
      isNormalUser = true;
      extraGroups = [
        (mkIf networking.networkmanager.enable "networkmanager")
        "wheel"
      ];
    };
  };
}
