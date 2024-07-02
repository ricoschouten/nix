{ inputs, pkgs, ... }:

{
  imports = with inputs.self.homeModules; [
    default
    fish
    starship
    zellij
    helix
  ];
  
  home.packages = with pkgs; [
    nil
  ];
    
  home.homeDirectory = /home/dev;
}

