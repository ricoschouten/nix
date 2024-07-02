{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hello
  ];
  
  home.stateVersion = "24.05";
}

