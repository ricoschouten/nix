{
  inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";
  
  inputs.flakelight.url = "github:nix-community/flakelight";
  inputs.flakelight-darwin.url = "github:cmacrae/flakelight-darwin";  
  
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.catppuccin.url = "github:catppuccin/nix";
  inputs.zjstatus.url = "github:dj95/zjstatus";
  inputs.nixvim.url = "github:nix-community/nixvim";

  outputs = { flakelight, ... }@inputs:
  
  flakelight ./. ({ lib, ... }:
  {
    imports = [
      ./flake/nixos.nix
      ./flake/home.nix
      ./flake/darwin.nix
    ];
    
    inherit inputs;

    nixDir = ./.;
        
    systems = lib.systems.flakeExposed;
  });
}

