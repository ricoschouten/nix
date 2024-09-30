{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flakelight.url = "github:nix-community/flakelight";
    flakelight-darwin.url = "github:cmacrae/flakelight-darwin";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-shell.url = "github:Mic92/nixos-shell";
    nixvim.url = "github:nix-community/nixvim";
    zjstatus.url = "github:dj95/zjstatus";
  };

  outputs =
    { flakelight, ... }@inputs:
    flakelight ./. {
      inherit inputs;
      systems = [ "x86_64-linux" ];
      nixDir = ./.;
    };
}
