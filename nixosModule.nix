{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  inherit (config) nixos;
  inherit (lib)
    mkDefault
    mkOption
    types
    substring
    stringLength
    toUpper
    ;

  inherit (inputs.self) nixosModules homeModules;
  inherit (inputs.home-manager.nixosModules) home-manager;

  capitalizeString = s: toUpper (substring 0 1 s) + substring 1 (stringLength s) s;
in
{
  imports = [
    home-manager
    # nixosModules.home-manager
    nixosModules.nixos-shell
  ];

  options = {
    nixos.hostName = mkOption {
      type = types.str;
      default = "nixos";
    };

    nixos.defaultUser = mkOption {
      type = types.str;
      default = "nixos";
    };
  };

  config = {
    networking.hostName = mkDefault nixos.hostName;

    users.defaultUserShell = pkgs.fish;

    users.users.default = {
      isNormalUser = true;
      name = nixos.defaultUser;
      description = capitalizeString nixos.defaultUser;

      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };

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

        programs.nixvim.enable = true;

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

    programs.fish = {
      enable = true;
      interactiveShellInit = "set -g fish_greeting";
    };

    programs.nh = {
      enable = true;
      flake = /etc/nixos;
    };

    services.sshd.enable = true;

    programs.mosh.enable = true;

    environment.systemPackages = [
      pkgs.nixd
      pkgs.nixfmt-rfc-style
    ];

    time.timeZone = "Europe/Amsterdam";

    i18n.defaultLocale = "en_US.UTF-8";

    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };
}
