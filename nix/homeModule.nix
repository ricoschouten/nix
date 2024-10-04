{ pkgs, inputs, ... }:

let
in
# inherit (inputs.self) homeModules;
{
  imports = [
    # inputs.catppuccin.homeManagerModules.catppuccin
    # inputs.self.homeModules.nixvim
  ];

  home.packages = [
    pkgs.vscode
  ];

  # catppuccin.enable = true;
  # catppuccin.flavor = "mocha";
}
