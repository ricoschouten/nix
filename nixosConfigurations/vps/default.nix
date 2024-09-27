{ inputs, ... }:

let
  inherit (inputs.disko.nixosModules) disko;
  inherit (inputs.nixos-facter-modules.nixosModules) facter;
  inherit (inputs.self) nixosModules;
in
{
  system = "x86_64-linux";
  modules = [
    nixosModules.default
    {
      nixos.hostName = "vps";
      nixos.userName = "rico";
    }
    facter
    { facter.reportPath = ./facter.json; }
    disko
    ./configuration.nix
  ];
}
