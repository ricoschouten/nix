{ lib, config, ... }:

with lib.types;

let
  inherit (lib) mkIf mkOption;
  inherit (lib.strings) concatStringsSep;
  inherit (lib.attrsets) concatMapAttrs;

  option = mkOption {
    type = nullOr (attrsOf str);
    default = {};
  };

  mkConfig = color: concatMapAttrs (name: value: {
    ${ concatStringsSep "_" [ "color" name ] } = mkIf (value != null) value;
  }) color;
in
{
  options.programs.zellij.zjstatus.color = option;

  config = with config.programs.zellij; mkIf (enable) {
    programs.zellij.settings.plugins.zjstatus = with zjstatus; mkConfig color;
  };
}

