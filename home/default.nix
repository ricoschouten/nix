{ pkgs, ... }:

{
  imports = [
    ./helix.nix
    ./zellij
    ./zjstatus
  ];

  home.packages = [
    pkgs.nixd
    pkgs.nixfmt-rfc-style
  ];

  programs.fish.enable = true;

  programs.git = {
    enable = true;
    userName = "Rico Schouten";
    userEmail = "ricoschouten@gmail.com";
  };

  programs.gh.enable = true;

  programs.zellij = {
    enable = true;

    autoAttach = true;
    autoExit = true;

    ui = {
      simplified = true;
      paneFrames = false;
      hideSessionName = true;
    };

    zjstatus.enable = true;
  };

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
}
