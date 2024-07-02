{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
  };

  home.sessionVariables = {
    ZELLIJ_AUTO_ATTACH = "true";
    ZELLIJ_AUTO_EXIT = "true";
  };

  xdg.configFile.zellij = let
    theme = "catppuccin-mocha";
    default_layout = "compact";
    default_mode = "locked";
  
    simplified_ui = true;
    pane_frames = false;
    pane_viewport_serialization = true;

    ui.pane_frames = {
        rounded_corners = true;
        hide_session_name = true;
    };
  in
  {
    enable = true;
    target = "zellij/config.kdl";
    text = ''
      theme "${theme}"
      default_layout "${default_layout}"
      default_mode "${default_mode}"
      simplified_ui ${simplified_ui}
      pane_frames ${pane_frames}
      pane_viewport_serialization ${pane_viewport_serialization}

      ui {
          pane_frames {
              rounded_corners ${ui.pane_frames.rounded_corners}
              hide_session_name ${ui.pane_frames.hide_session_name}
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
}

