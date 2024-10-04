{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flakelight.url = "github:nix-community/flakelight";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    { flakelight, ... }@inputs:
    flakelight ./. {
      inherit inputs;

      nixosConfigurations."nixos" = {
        system = "x86_64-linux";
        modules = [
          inputs.self.nixosModules.default
          {
            networking.hostName = "nixos";
            user.name = "rico";
            user.description = "Rico Schouten";
          }
        ];
      };
    };
}
