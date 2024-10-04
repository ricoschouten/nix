{
  lib,
  config,
  inputs,
  ...
}:

let
  inherit (lib) mkIf mkDefault;
  inherit (config) programs;
  inherit (inputs.nixvim) homeManagerModules;
in
{
  imports = [ homeManagerModules.nixvim ];

  config = mkIf programs.nixvim.enable {
    programs.nixvim.defaultEditor = mkDefault true;
  };
}
