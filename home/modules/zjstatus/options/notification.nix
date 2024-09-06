{ lib, config, ... }:

with lib.types;

let
  inherit (lib) mkIf mkOption;

  options = {
    format-unread = mkOption {
      type = nullOr str;
      default = null;
    };
  
    format-no-notifications = mkOption {
      type = nullOr str;
      default = null;
    };

    show-interval = mkOption {
      type = nullOr ints.unsigned;
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
  options.programs.zellij.zjstatus.notification = mkOptions options;

  config = with config.programs.zellij; mkIf (enable) {
    programs.zellij.settings.plugins.zjstatus = with zjstatus.notification; {
      notification_format_unread = mkIf (format-unread != null) format-unread;
      notification_format_no_notifications = mkIf (format-no-notifications != null) format-no-notifications;
      notification_show_interval = mkIf (show-interval != null) show-interval;
    };
  };
}

