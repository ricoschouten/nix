{ inputs, ... }:

let
  inherit (inputs.self) nixosModules;
in
{
  system = "x86_64-linux";
  modules = [
    nixosModules.default
    {
      networking.hostName = "prodesk";
      user.name = "rico";
      user.description = "Rico Schouten";
      home = import ./home.nix;
    }
    ./configuration.nix
    ./hardware-configuration.nix
  ];
}
