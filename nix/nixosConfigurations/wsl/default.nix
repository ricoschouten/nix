{ inputs, ... }:

let
  inherit (inputs.self) nixosModules;
in
{
  system = "x86_64-linux";
  modules = [
    nixosModules.default
    {
      networking.hostName = "wsl";
      wsl.enable = true;
      wsl.defaultUser = "rico";
      home = import ./home.nix;
      system.stateVersion = "24.11";
    }
  ];
}
