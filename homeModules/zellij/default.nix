{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  inherit (config) programs;
  inherit (lib)
    mkIf
    isString
    isPath
    mkOption
    mkEnableOption
    ;

  inherit (lib.types) str path either;

  mkIfString = value: mkIf (isString value) value;
  mkIfPath = value: mkIf (isPath value) value;
in
{
  options = {
    programs.zellij = {
      layout = mkOption {
        type = either str path;
        default = ./default.kdl;
        description = "The default layout.";
      };

      autoAttach = mkEnableOption "automatic attach beheviour";
      autoExit = mkEnableOption "automatic exit beheviour";
    };
  };

  config = mkIf programs.zellij.enable {
    programs.zellij.settings.plugins."zjstatus" = {
      _props.location = "file:${inputs.zjstatus.packages.${pkgs.system}.default}/bin/zjstatus.wasm";
    };

    xdg.configFile."zellijDefaultLayout" = {
      enable = true;
      target = "zellij/layouts/default.kdl";
      text = mkIfString programs.zellij.layout;
      source = mkIfPath programs.zellij.layout;
    };

    programs.fish.interactiveShellInit =
      mkIf (programs.zellij.autoAttach || programs.zellij.autoExit)
        ''
          eval (zellij setup --generate-auto-start fish | string collect)
        '';

    home.sessionVariables = {
      ZELLIJ_AUTO_ATTACH = mkIf programs.zellij.autoAttach "true";
      ZELLIJ_AUTO_EXIT = mkIf programs.zellij.autoExit "true";
    };
  };
}
