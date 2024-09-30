{ inputs, ... }:

let
  inherit (inputs.self) nixosModules;
in
{
  system = "x86_64-linux";
  modules = [
    nixosModules.default
    {
      user.name = "rico";
      wsl.enable = true;
      home.stateVersion = "24.11";
      system.stateVersion = "24.11";
    }
  ];
}
