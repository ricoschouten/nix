{
  lib,
  pkgs,
  inputs,
  ...
}:

let
  inherit (lib) mkDefault;
  inherit (inputs.self) homeModules;
  inherit (inputs.home-manager.nixosModules) home-manager;
in
{
  imports = [ home-manager ];

  config = mkDefault {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        inherit inputs;
      };
      users.default = {
        imports = [
          homeModules.nixvim
          homeModules.helix
          homeModules.zellij
        ];

        home.packages = [
          pkgs.nixd
          pkgs.nixfmt-rfc-style
        ];

        programs.git = {
          enable = true;
          userName = "Rico Schouten";
          userEmail = "ricoschouten@gmail.com";
        };

        programs.gh.enable = true;

        programs.fish.enable = true;

        programs.zellij = {
          enable = true;
          enableFishIntegration = true;

          layout = ./zjstatus.kdl;

          autoAttach = true;
          autoExit = true;
        };

        # programs.nixvim.enable = true;

        programs.helix = {
          enable = true;

          languages = {
            language-server.nixd = {
              command = "nixd";
            };

            language = [
              {
                name = "nix";
                language-servers = [ "nixd" ];
                formatter.command = "nixfmt";
                auto-format = true;
              }
            ];
          };
        };

        home.stateVersion = "24.05";
      };
    };
  };
}
