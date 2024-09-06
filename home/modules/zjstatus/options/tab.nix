{ lib, config, ... }:

with lib.types;

let
  inherit (lib) mkIf mkOption;
  inherit (lib.attrsets) genAttrs;
  
  genOptions = names: genAttrs names (name: mkOption {
    type = nullOr (if name != "display-count" then str else ints.unsigned);
    default = null;
  });

  mkOptions = names: mkOption {
    type = submodule {
      options = genOptions names;
    };
    default = {};
  };

  names = [
    "normal"
    "normal-fullscreen"
    "normal-sync"
    "active"
    "active-fullscreen"
    "active-sync"
    "separator"
    "rename"
    "sync-indicator"
    "fullscreen-indicator"
    "floating-indicator"
    "display-count"
    "truncate-start-format"
    "truncate-end-format"
  ];
in
{
  options.programs.zellij.zjstatus.tab = mkOptions names;
  
  config = with config.programs.zellij; mkIf (enable) {
    programs.zellij.settings.plugins.zjstatus = with zjstatus.tab; {
      tab_normal = mkIf (normal != null) normal;
      tab_normal_fullscreen = mkIf (normal-fullscreen != null) normal-fullscreen;
      tab_normal_sync = mkIf (normal-sync != null) normal-sync;
      
      tab_active = mkIf (active != null) active;
      tab_active_fullscreen = mkIf (active-fullscreen != null) active-fullscreen;
      tab_active_sync = mkIf (active-sync != null) active-sync;
      
      tab_separator = mkIf (separator != null) separator;
      tab_rename = mkIf (rename != null) rename;

      tab_sync_indicator = mkIf (sync-indicator != null) sync-indicator;
      tab_fullscreen_indicator = mkIf (fullscreen-indicator != null) fullscreen-indicator;
      tab_floating_indicator = mkIf (floating-indicator != null) floating-indicator;

      tab_display_count = mkIf (display-count != null) display-count;
      tab_truncate_start_format = mkIf (truncate-start-format != null) truncate-start-format;
      tab_truncate_end_format = mkIf (truncate-end-format != null) truncate-end-format;
    };
  };
}

