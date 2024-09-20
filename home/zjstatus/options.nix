{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkIf
    mkOption
    mkEnableOption
    mapAttrs
    genAttrs
    ;

  inherit (lib.types)
    str
    bool
    ints
    path
    enum
    attrs
    nullOr
    attrsOf
    submodule
    ;

  inherit (lib.attrsets) concatMapAttrs;

  cfg = config.programs.zellij.zjstatus;

  mkFormatOptions =
    names:
    genAttrs names (
      _:
      mkOption {
        type = nullOr str;
        default = null;
      }
    );

  mkColorConfig =
    color:
    concatMapAttrs (name: value: {
      ${"color_" + name} = value;
    }) color;

  mkCommandConfig =
    command:
    concatMapAttrs (
      name: attrs:
      concatMapAttrs (option: value: {
        ${"command_" + name + "_" + option} = mkIfNotNull value;
      }) attrs
    ) command;

  mkIfNotNull = value: mkIf (value != null) value;
in
{
  options = {
    programs.zellij.zjstatus = {
      enable = mkEnableOption "zjstatus";

      settings = {
        color = mkOption {
          type = attrsOf str;
          default = { };
        };

        format = {
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

          hideOnOverlength = mkOption {
            type = bool;
            default = false;
          };

          precedence = mkOption {
            type = nullOr str;
            default = null;
          };
        };

        border = {
          enabled = mkOption {
            type = bool;
            default = false;
          };

          char = mkOption {
            type = nullOr str;
            default = null;
          };

          format = mkOption {
            type = nullOr str;
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

        hideFrameForSinglePane = mkOption {
          type = bool;
          default = false;
        };

        mode =
          let
            names = [
              "normal"
              "locked"
              "resize"
              "pane"
              "tab"
              "scroll"
              "enterSearch"
              "search"
              "renameTab"
              "renamePane"
              "session"
              "move"
              "prompt"
              "tmux"
            ];

            defaultToMode = mkOption {
              type = nullOr (enum names);
              default = null;
            };
          in
          mkFormatOptions names // { inherit defaultToMode; };

        tab =
          let
            attrs = {
              "normal" = nullOr str;
              "normalFullscreen" = nullOr str;
              "normalSync" = nullOr str;
              "active" = nullOr str;
              "activeFullscreen" = nullOr str;
              "activeSync" = nullOr str;
              "separator" = nullOr str;
              "rename" = nullOr str;
              "syncIndicator" = nullOr str;
              "fullscreenIndicator" = nullOr str;
              "floatingIndicator" = nullOr str;
              "displayCount" = nullOr ints.unsigned;
              "truncateStartFormat" = nullOr str;
              "truncateEndFormat" = nullOr str;
            };
          in
          mapAttrs (
            _: value:
            mkOption {
              type = value;
              default = null;
            }
          ) attrs;

        notification = {
          formatUnread = mkOption {
            type = nullOr str;
            default = null;
          };

          formatNoNotifications = mkOption {
            type = nullOr str;
            default = null;
          };

          showInterval = mkOption {
            type = nullOr ints.unsigned;
            default = null;
          };
        };

        command = mkOption {
          type = attrsOf (submodule {
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
          });
          default = { };
        };

        datetime = mkOption {
          type = nullOr str;
          default = null;
        };

        datetimeFormat = mkOption {
          type = nullOr str;
          default = null;
        };

        datetimeTimezone = mkOption {
          type = nullOr str;
          default = null;
        };
      };
    };
  };

  config = mkIf (config.programs.zellij.enable && cfg.enable) {
    programs.zellij.settings.plugins.zjstatus = {
      _props.location = "file:${pkgs.zjstatus}/bin/zjstatus.wasm";

      format_left = mkIfNotNull cfg.settings.format.left;
      format_center = mkIfNotNull cfg.settings.format.center;
      format_right = mkIfNotNull cfg.settings.format.right;
      format_space = mkIfNotNull cfg.settings.format.space;

      format_hide_on_overlength = mkIf cfg.settings.format.hideOnOverlength true;
      format_precedence = mkIfNotNull cfg.settings.format.precedence;

      border_enabled = mkIf cfg.settings.border.enabled true;
      border_char = mkIfNotNull cfg.settings.border.char;
      border_format = mkIfNotNull cfg.settings.border.format;
      border_position = mkIfNotNull cfg.settings.border.position;

      hide_frame_for_single_pane = mkIf cfg.settings.hideFrameForSinglePane true;

      mode_normal = mkIfNotNull cfg.settings.mode.normal;
      mode_locked = mkIfNotNull cfg.settings.mode.locked;
      mode_resize = mkIfNotNull cfg.settings.mode.resize;
      mode_pane = mkIfNotNull cfg.settings.mode.pane;
      mode_tab = mkIfNotNull cfg.settings.mode.tab;
      mode_scroll = mkIfNotNull cfg.settings.mode.scroll;
      mode_enter_search = mkIfNotNull cfg.settings.mode.enterSearch;
      mode_search = mkIfNotNull cfg.settings.mode.search;
      mode_rename_tab = mkIfNotNull cfg.settings.mode.renameTab;
      mode_rename_pane = mkIfNotNull cfg.settings.mode.renamePane;
      mode_session = mkIfNotNull cfg.settings.mode.session;
      mode_move = mkIfNotNull cfg.settings.mode.move;
      mode_prompt = mkIfNotNull cfg.settings.mode.prompt;
      mode_tmux = mkIfNotNull cfg.settings.mode.tmux;

      mode_default_to_mode = mkIfNotNull cfg.settings.mode.defaultToMode;

      tab_normal = mkIfNotNull cfg.settings.tab.normal;
      tab_normal_fullscreen = mkIfNotNull cfg.settings.tab.normalFullscreen;
      tab_normal_sync = mkIfNotNull cfg.settings.tab.normalSync;

      tab_active = mkIfNotNull cfg.settings.tab.active;
      tab_active_fullscreen = mkIfNotNull cfg.settings.tab.activeFullscreen;
      tab_active_sync = mkIfNotNull cfg.settings.tab.activeSync;

      tab_separator = mkIfNotNull cfg.settings.tab.separator;
      tab_rename = mkIfNotNull cfg.settings.tab.rename;

      tab_sync_indicator = mkIfNotNull cfg.settings.tab.syncIndicator;
      tab_fullscreen_indicator = mkIfNotNull cfg.settings.tab.fullscreenIndicator;
      tab_floating_indicator = mkIfNotNull cfg.settings.tab.floatingIndicator;

      tab_display_count = mkIfNotNull cfg.settings.tab.displayCount;
      tab_truncate_start_format = mkIfNotNull cfg.settings.tab.truncateStartFormat;
      tab_truncate_end_format = mkIfNotNull cfg.settings.tab.truncateEndFormat;

      notification_format_unread = mkIfNotNull cfg.settings.notification.formatUnread;
      notification_format_no_notifications = mkIfNotNull cfg.settings.notification.formatNoNotifications;
      notification_show_interval = mkIfNotNull cfg.settings.notification.showInterval;

      datetime = mkIfNotNull cfg.settings.datetime;
      datetime_format = mkIfNotNull cfg.settings.datetimeFormat;
      datetime_timezone = mkIfNotNull cfg.settings.datetimeTimezone;
    } // mkColorConfig cfg.settings.color // mkCommandConfig cfg.settings.command;
  };
}
