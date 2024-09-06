{ inputs, ... }:

{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
    ./zellij.nix
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };
}

