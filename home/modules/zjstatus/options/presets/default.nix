{ lib, config, ... }:

let
  inherit (lib) mkOption types;
in
{
  imports = [ ./${config.programs.zellij.zjstatus.preset ? default}.nix ];
  
  options.programs.zellij.zjstatus.preset = mkOption {
    type = types.enum [
      "catppuccin-mocha"
      "catppuccin-latte"
      "catppuccin-frappe"
      "catppuccin-macchiato"
    ];
  };

  programs.zellij.zjstatus.settings = config.programs.zellij.zjstatus.settings // {
    
  };
}

