{ lib, config, ... }:

with lib.types;

let
  inherit (lib) mkIf mkOption;
  inherit (lib.strings) concatStringsSep;
  inherit (lib.attrsets) concatMapAttrs;
  
  options = {
    command = mkOption {
      type = nullOr str;
      default = null;
    };

    format = mkOption {
      type = nullOr str;
      default = null;
    };

    interval = mkOption {
      type = nullOr ints.unsigned;
      default = 0;
    };

    rendermode = mkOption {
      type = nullOr (enum [
        "static"
        "dynamic"
        "raw"
      ]);
      default = null; 
    };

    cwd = mkOption {
      type = nullOr path;
      default = null;
    };

    env = mkOption {
      type = nullOr attrs;
      default = null;
    };
  };
  
  mkOptions = options: mkOption {
    type = attrsOf (submodule {
      inherit options;
    });
    default = {};
  };

  mkConfig = command: concatMapAttrs (name: attrs: concatMapAttrs (option: value: {
    ${ concatStringsSep "_" [ "command" name option ] } = mkIf (value != null) value;
  }) attrs) command;
in
{
  options.programs.zellij.zjstatus.command = mkOptions options;

  config = with config.programs.zellij; mkIf (enable) {
    programs.zellij.settings.plugins.zjstatus = with zjstatus; mkConfig command;
  };
}

