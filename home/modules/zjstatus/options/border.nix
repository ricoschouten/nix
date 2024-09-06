{ lib, config, ... }:

with lib.types;

let
  inherit (lib) mkIf mkOption;

  options = {
    enabled = mkOption {
      type = bool;
      default = false;
    };
  
    char = mkOption {
      type = str;
      default = null;
    };
  
    format = mkOption {
      type = str;
      default = null;
    };
  
    position = mkOption {
      type = nullOr (enum [
        "top"
        "bottom"
      ]);
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
  options.programs.zellij.zjstatus.border = mkOptions options;

  config = with config.programs.zellij; mkIf (enable) {
    programs.zellij.settings.plugins.zjstatus = with zjstatus.border; {
      border_enabled = mkIf (enabled) enabled;
      border_char = mkIf (enabled && char != null) char;
      border_format = mkIf (enabled && format != null) format;
      border_position = mkIf (enabled && position != null) position;
    };
  };
}

