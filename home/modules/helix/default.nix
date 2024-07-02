{
  programs.helix = {
    enable = true;
    defaultEditor = true;
        
    settings.theme = "catppuccin_mocha";
    
    settings.editor = {
      auto-save = true;
      auto-format = true;

      file-picker.hidden = false;
      
      bufferline = "never";
      color-modes = true;
      true-color = true;
      
      cursor-shape.insert = "bar";
      cursor-shape.normal = "block";
      cursor-shape.select = "underline";
    };

    settings.editor.soft-wrap = {
      enable = true;
      max-wrap = 25;
      max-indent-retain = 0;
      wrap-indicator = "";
    };
    
    settings.editor.statusline = {
      separator = "│";
      
      mode.normal = "N";
      mode.insert = "I";
      mode.select = "S";
      
      left = [ "mode" "spinner" ];
      center = [ "file-name" ];
      right = [
        "diagnostics"
        "selections"
        "position"          
        "file-encoding"
        "file-line-ending"
        "file-type"
      ];
    };
    
    settings.keys = {
      normal.esc = [
        "collapse_selection"
        "keep_primary_selection"
      ];

      normal.tab = {
        tab = ":buffer-next";
        S-tab = ":buffer-previous";
      };
    };
  };
}

