{
  config,
  lib,
  ...
}:

let
  inherit (lib) mkIf mkDefault;

  cfg = config.programs.zellij.zjstatus;
  ui = config.programs.zellij.ui;
in
{
  imports = [ ./options.nix ];

  config = mkIf (config.programs.zellij.enable && cfg.enable) {
    programs.zellij = mkDefault {
      zjstatus.settings = {
        format.left =
          if ui.hideSessionName then
            "#[fg=#FFFFFF,bold] {mode} {tabs}"
          else
            "#[fg=#FFFFFF,bold] {session} {mode} {tabs}";

        format.right =
          if ui.simplified then
            "#[bg=#8A8A8A,fg=#000000]  #[bg=#8A8A8A,fg=#000000,bold]{swap_layout} #[bg=#000000,fg=#8A8A8A]"
          else
            "#[bg=#8A8A8A,fg=#000000] #[bg=#8A8A8A,fg=#000000,bold]{swap_layout} #[bg=#000000,fg=#8A8A8A]";

        mode = {
          locked = "#[fg=#FF00D9,bold] {name} ";
          normal = "#[fg=#AFFF00,bold] {name} ";
          resize = "#[fg=#D75F00,bold] {name} ";
          defaultToMode = "resize";
        };

        tab.normal =
          if ui.simplified then
            "#[bg=#8A8A8A,fg=#000000]  #[bg=#8A8A8A,fg=#000000,bold]{name} {sync_indicator}{fullscreen_indicator}{floating_indicator} #[bg=#000000,fg=#8A8A8A]"
          else
            "#[bg=#8A8A8A,fg=#000000] #[bg=#8A8A8A,fg=#000000,bold]{name} {sync_indicator}{fullscreen_indicator}{floating_indicator} #[bg=#000000,fg=#8A8A8A]";

        tab.active =
          if ui.simplified then
            "#[bg=#AFFF00,fg=#000000]  #[bg=#AFFF00,fg=#000000,bold]{name} {sync_indicator}{fullscreen_indicator}{floating_indicator} #[bg=#000000,fg=#AFFF00]"
          else
            "#[bg=#AFFF00,fg=#000000] #[bg=#AFFF00,fg=#000000,bold]{name} {sync_indicator}{fullscreen_indicator}{floating_indicator} #[bg=#000000,fg=#AFFF00]";

        tab = {
          syncIndicator = " ";
          fullscreenIndicator = "□ ";
          floatingIndicator = "󰉈 ";
        };
      };

      ui.template = ./default.kdl;
    };
  };
}
