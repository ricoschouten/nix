{ inputs, pkgs, ... }:

{
  imports = with inputs.self.homeModules; [
    default
    fish
    starship
    zellij
    zjstatus
    helix
    nixvim
    catppuccin
  ];
  
  home.packages = with pkgs; [
    nil
  ];
    
  home.homeDirectory = /home/dev;
}

