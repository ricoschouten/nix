{ lib, config, inputs, pkgs, ... }:


let
  inherit (lib) mkIf mkEnableOption;
in
{
  imports = [ inputs.nixos-shell.nixosModules.nixos-shell ];
  
  options.vm.enable = mkEnableOption "Enable virtualization";
  
  config = mkIf config.vm.enable {
    environment.systemPackages = with pkgs; [
      nixos-shell
    ];  
  };
}

