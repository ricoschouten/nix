{ config, lib, ... }:

let
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

  cfg = config.programs.zellij;
in
{
  options = {
    programs.zellij = {
      autoAttach = mkEnableOption "zellij_auto_attach";
      autoExit = mkEnableOption "zellij_auto_exit";

      theme = mkOption {
        type = str;
        default = "default";
      };

      ui = {
        hideSessionName = mkEnableOption "ui.pane_frames.hide_session_name";
        simplified = mkEnableOption "simplified_ui";
        paneFrames = mkEnableOption "pane_frames" // {
          default = true;
        };

        template = mkOption {
          type = either str path;
          default = ./default.kdl;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.zellij.settings = {
      theme = cfg.theme;

      simplified_ui = mkIf cfg.ui.simplified true;
      pane_frames = mkIf (!cfg.ui.paneFrames) false;

      ui.pane_frames = {
        hide_session_name = mkIf cfg.ui.hideSessionName true;
      };
    };

    xdg.configFile."zellij-layout" = {
      enable = true;
      target = "zellij/layouts/default.kdl";
      text = mkIfString cfg.ui.template;
      source = mkIfPath cfg.ui.template;
    };

    programs.fish.interactiveShellInit = mkIf (cfg.autoAttach || cfg.autoExit) ''
      eval (zellij setup --generate-auto-start fish | string collect)
    '';

    home.sessionVariables = {
      ZELLIJ_AUTO_ATTACH = mkIf cfg.autoAttach "true";
      ZELLIJ_AUTO_EXIT = mkIf cfg.autoExit "true";
    };
  };
}
