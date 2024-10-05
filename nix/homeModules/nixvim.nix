{
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (config) programs;
  inherit (lib) mkIf mkDefault;
  inherit (inputs.nixvim) homeManagerModules;
in
{
  imports = [ homeManagerModules.nixvim ];

  config = mkDefault {
    programs.nixvim = mkIf programs.nixvim.enable {
      defaultEditor = true;
      colorschemes.base16.enable = true;

      plugins = {
        which-key.enable = true;
      };
    };
  };
}
