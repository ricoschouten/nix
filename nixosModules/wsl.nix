{
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (config) user wsl;
  inherit (lib) mkIf;
  inherit (inputs) nixos-wsl;
in
{
  imports = [ nixos-wsl.nixosModules.default ];

  wsl = mkIf wsl.enable {
    defaultUser = user.name;
  };
}
