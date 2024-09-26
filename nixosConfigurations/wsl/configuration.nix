# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{
  config,
  lib,
  pkgs,
  nixpkgs,
  nixos-wsl,
  home-manager,
  ...
}:

{
  imports = [
    nixos-wsl.nixosModules.default
    home-manager.nixosModules.home-manager
  ];

  wsl.enable = true;
  wsl.defaultUser = "wsl";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    # extraSpecialArgs = inputs;
    # users."wsl" = import ./home;
  };

  system.stateVersion = "24.11";
}
