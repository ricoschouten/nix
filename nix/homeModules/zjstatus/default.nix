{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

let
  inherit (lib) mkIf mkOverride;
  inherit (config) programs;
  inherit (inputs) zjstatus;
in
{
  config = mkIf programs.zellij.enable {
    programs.zellij = {
      layout = mkOverride 500 ./default.kdl;

      settings.plugins = {
        "zjstatus" = {
          _props.location = "file:${zjstatus.packages.${pkgs.system}.default}/bin/zjstatus.wasm";
        };
      };
    };
  };
}
