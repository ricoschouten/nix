{ lib, config, ... }:

with lib.types;

let
  inherit (lib) mkIf mkOption;
  inherit (lib.strings) stringToCharacters;
  inherit (lib.lists) unique subtractLists;
  options = {
    left = mkOption {
      type = nullOr str;
      default = null;
    };
  
    center = mkOption {
      type = nullOr str;
      default = null;
    };
  
    right = mkOption {
      type = nullOr str;
      default = null;
    };
  
    space = mkOption {
      type = nullOr str;
      default = null;
    };

    hide-on-overlength = mkOption {
      type = bool;
      default = false;
    };

    precedence = mkOption {
      type = nullOr str // {
        check = (value: (subtractLists [ "l" "r" "c"] (unique (stringToCharacters value))) == []);
      };
      default = null;
    };
  };

  mkOptions = options: mkOption {
    type = submodule {
      inherit options;
    };
    default = {};
  };
in
{
  options.programs.zellij.zjstatus.format = mkOptions options;

  config = with config.programs.zellij; mkIf (enable) {
    programs.zellij.settings.plugins.zjstatus = with zjstatus.format; {
      format_left = mkIf (left != null) left;
      format_center = mkIf (center != null) center;
      format_right = mkIf (right != null) right;
      format_space = mkIf (space != null) space;

      format_hide_on_overlength = mkIf (hide-on-overlength) hide-on-overlength;
      format_precedence = mkIf (hide-on-overlength && precedence != null) precedence;
    };
  };
}

