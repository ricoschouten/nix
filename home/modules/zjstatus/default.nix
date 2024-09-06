{ lib, pkgs, config, ...}:

let
  inherit (lib) mkIf;
in
{
  imports = [ ./options ];
  
  config = with config.programs.zellij; mkIf (enable) {
    programs.zellij.settings.plugins.zjstatus = {
      _props.location = "file:${pkgs.zjstatus}/bin/zjstatus.wasm";
    };
  };
}

