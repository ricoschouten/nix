{ lib, config, ...}:

with lib.types;

let
  inherit (lib) mkIf mkOption;
 
  options.hide-frame-for-single-pane = mkOption {
    type = bool;
    default = false;
  };
in
{ 
  options.programs.zellij.zjstatus.hide-frame-for-single-pane = options.hide-frame-for-single-pane;
  
  config = with config; mkIf (config.programs.zellij.enable) {
    programs.zellij.settings.plugins.zjstatus = with programs.zellij.zjstatus; {
      hide_frame_for_single_pane = mkIf (hide-frame-for-single-pane) hide-frame-for-single-pane;
    };
  };
}

