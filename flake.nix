{
  inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";
  inputs.flakelight.url = "github:nix-community/flakelight";
  inputs.flakelight-darwin.url = "github:cmacrae/flakelight-darwin";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.nixos-shell.url = "github:Mic92/nixos-shell";
  
  outputs = { flakelight, ... }@inputs:
  
  flakelight ./. ({ lib, config, ... }:
  {  
    inherit inputs;

    systems = lib.systems.flakeExposed;
   
    nixDir = ./.;
    nixDirAliases = {
      nixosModule          = [ "os" ];
      nixosModules         = [ "os/modules" ];
      nixosConfigurations  = [ "os/configs" ];
      
      homeModule           = [ "home" ];
      homeModules          = [ "home/modules" ];
      homeConfigurations   = [ "home/configs" ];
      
      darwin               = [ "darwin" ];
      darwinModules        = [ "darwin/modules" ];
      darwinConfigurations = [ "darwin/configs" ];
    };

    devShell.packages = pkgs: with pkgs; [
      hello
    ];
  });
}

