{ lib, ... }:

let
  inherit (lib.trivial) boolToString;
  
  auto-attach = true;
  auto-exit = true;

  default-mode = "locked";
  simplified-ui = true;
  pane-frames = false;
  pane-viewport-serialization = true;

  ui.pane-frames = {
    rounded-corners = true;
    hide-session-name = true;
  };
in
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
  };
  
  xdg.configFile.zellij = {
    enable = true;
    target = "zellij/layouts/default.kdl";
    text = ''    
      default_mode "${default-mode}"
    
      pane_frames ${boolToString pane-frames} 
      pane_viewport_serialization ${boolToString pane-viewport-serialization} 

      ui {
        pane_frames {
          rounded_corners true
          hide_session_name true
        }
      }
      
      layout {
        default_tab_template {
          pane size=1 borderless=true {
            plugin location="zjstatus"
          }
          children
        }
      }

      keybinds {
        shared {
          unbind "Ctrl q";
          bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
          bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
          bind "Alt j" "Alt Down" { MoveFocus "Down"; }
          bind "Alt k" "Alt Up" { MoveFocus "Up"; }
          bind "Alt z" { TogglePaneEmbedOrFloating; }
          bind "Alt m" { ToggleFloatingPanes; }
          bind "Alt n" { NewPane; }
          bind "Alt t" { NewTab; }
          bind "Alt q" { Detach; }
          bind "Alt w" { CloseTab; }
          bind "Alt i" { MoveTab "Left"; }
          bind "Alt o" { MoveTab "Right"; }
          bind "Alt [" { PreviousSwapLayout; }
          bind "Alt ]" { NextSwapLayout; }
          bind "Alt 1" { GoToTab 1; }
          bind "Alt 2" { GoToTab 2; }
          bind "Alt 3" { GoToTab 3; }
          bind "Alt 4" { GoToTab 4; }
          bind "Alt 5" { GoToTab 5; }
          bind "Alt 6" { GoToTab 6; }
          bind "Alt 7" { GoToTab 7; }
          bind "Alt 8" { GoToTab 8; }
          bind "Alt 9" { GoToTab 9; }
          bind "Alt 0" { GoToTab 10; }
          bind "Alt -" { GoToPreviousTab; }
          bind "Alt =" { GoToNextTab; }
        }
      }
    '';
  };

  home.sessionVariables = {
    ZELLIJ_AUTO_ATTACH = boolToString auto-attach;
    ZELLIJ_AUTO_EXIT = boolToString auto-exit;
  };
}

