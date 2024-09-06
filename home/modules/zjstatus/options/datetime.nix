{ lib, config, ... }:

with lib.types;

let
  inherit (lib) mkIf mkOption;

  options = {
    datetime = mkOption {
      type = nullOr str;
      default = null;
    };
  
    datetime-format = mkOption {  
      type = nullOr str;
      default = null;
    };
  
    datetime-timezone = mkOption {    
      type = nullOr str;
      default = null;
    };
  };
in
{
  options.programs.zellij.zjstatus = options;

  config = with config.programs.zellij; mkIf (enable) {
    programs.zellij.settings.plugins.zjstatus = with zjstatus; {
      datetime = mkIf (datetime != null) datetime;
      datetime_format = mkIf (datetime-format != null) datetime-format;
      datetime_timezone = mkIf (datetime-timezone != null) datetime-timezone;
    };
  };
}

