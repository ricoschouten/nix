{ lib, config, ...}:

let
  inherit (lib) mkIf mkDefault;
in
{
  imports = [
    ./color.nix
    ./format.nix
    ./border.nix
    ./mode.nix
    ./tab.nix
    ./command.nix
    ./notification.nix
    ./datetime.nix
    ./misc.nix
  ];

  config = with config.programs.zellij; mkIf (enable) {
    programs.zellij.zjstatus = mkDefault {
      
      format = {
        left = "{mode} #[fg=#89B4FA,bold]{session}";
        center = "{tabs}";
        right = "{command_git_branch} {datetime}";
        space = "";
      };
      
      border = {
        enabled = false;
        char = "─";
        format = "#[fg=#6C7086]{char}";
        position = "top";
      };
  
      hide-frame-for-single-pane = false;
    
      mode = {
        normal = "#[bg=blue] ";
        tmux = "#[bg=#ffc387] ";
      };
      
      tab = {
        normal = "#[fg=#6C7086] {name} ";
        active = "#[fg=#9399B2,bold,italic] {name} ";
      };

      command = {
        "git_branch" = {
          command = "git rev-parse --abbrev-ref HEAD";
          format = "#[fg=blue] {stdout} ";
          interval = 10;
          rendermode = "static";
        };
      };
      
      datetime = "#[fg=#6C7086,bold] {format} ";
      datetime-format = "%A, %d %b %Y %H:%M";
      datetime-timezone = "Europe/Amsterdam";
    };
  };
}

