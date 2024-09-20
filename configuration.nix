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
  zjstatus,
  ...
}:

{
  imports = [
    nixos-wsl.nixosModules.default
    home-manager.nixosModules.home-manager
  ];

  nixpkgs.overlays = [
    (final: prev: {
      zjstatus = zjstatus.packages.${prev.system}.default;
    })
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    # extraSpecialArgs = inputs;
    users."nixos" = import ./home;
  };

  users.defaultUserShell = pkgs.fish;

  programs.fish = {
    enable = true;
    interactiveShellInit = "set -g fish_greeting";
  };

  programs.nh = {
    enable = true;
    flake = /etc/nixos;
  };

  environment.systemPackages = [
  
  ];

  nix.nixPath = [ "nixpkgs=${nixpkgs}" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
