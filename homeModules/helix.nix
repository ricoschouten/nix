{ config, lib, ... }:

let
  inherit (config) programs;
  inherit (lib) mkIf mkDefault;
in
{
  config = mkIf programs.helix.enable {
    programs.helix.settings = mkDefault {
      theme = "base16_transparent";

      editor = {
        lsp.display-messages = true;
        file-picker.hidden = false;

        true-color = true;
        undercurl = true;
        color-modes = true;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        statusline = {
          mode.normal = "N";
          mode.insert = "I";
          mode.select = "S";
        };
      };

      keys.normal = {
        space.space = "file_picker";
        esc = [
          "collapse_selection"
          "keep_primary_selection"
        ];
      };
    };
  };
}
