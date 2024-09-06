{ lib, config, ... }:

with lib.types;

let
  inherit (lib) mkIf mkOption;
  inherit (lib.attrsets) genAttrs;
  
  genOptions = names: genAttrs names (name: mkOption {
    type = nullOr (if name == "default-to-mode" then enum names else str);
    default = null;
  });
    
  mkOptions = names: mkOption {
    type = submodule {
      options = genOptions names;
    };
    default = {};
  };

  modes = [
    "normal"
    "locked"
    "resize"
    "pane"
    "tab"
    "scroll"
    "enter-search"
    "search"
    "rename-tab"
    "rename-pane"
    "session"
    "move"
    "prompt"
    "tmux"
    "default-to-mode"
  ];
in
{ 
  options.programs.zellij.zjstatus.mode = mkOptions modes;
  
  config = with config.programs.zellij; mkIf (enable) {
    programs.zellij.settings.plugins.zjstatus = with zjstatus.mode; {
      mode_normal = mkIf (normal != null) normal;
      mode_locked = mkIf (locked != null) locked;
      mode_resize = mkIf (resize != null) resize;
      mode_pane = mkIf (pane != null) pane;
      mode_tab = mkIf (tab != null) tab;
      mode_scroll = mkIf (scroll != null) scroll;
      mode_enter_search = mkIf (enter-search != null) enter-search;
      mode_search = mkIf (search != null) search;
      mode_rename_tab = mkIf (rename-tab != null) rename-tab;
      mode_rename_pane = mkIf (rename-pane != null) rename-pane;
      mode_session = mkIf (session != null) session;
      mode_move = mkIf (move != null) move;
      mode_prompt = mkIf (prompt != null) prompt;
      mode_tmux = mkIf (tmux != null) tmux;
      
      mode_default_to_mode = mkIf (default-to-mode != null) default-to-mode;
    };
  };
}

