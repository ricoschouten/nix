{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hello
  ];

  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.lazygit.enable = true;
  
  home.stateVersion = "24.05";
}

