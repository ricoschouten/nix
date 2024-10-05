{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

let
  inherit (lib) mkIf mkDefault;
  inherit (config) programs;
  inherit (inputs.hyprland-plugins) packages;
in
{
  config = mkIf programs.hyprland.enable {
    # programs.hyprland = { };

    home.programs.kitty.enable = mkDefault true;
    home.programs.waybar.enable = true;
    home.programs.rofi.enable = true;

    environment.sessionVariables = {
      "NIXOS_OZONE_WL" = mkDefault "1";
    };

    home.wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        bind =
          [
            "$mod, F, exec, firefox"
            # ", Print, exec, grimblast copy area"
          ]
          ++ (
            # Workspaces
            # bind $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (
              builtins.genList (
                i:
                let
                  ws = i + 1;
                in
                [
                  "$mod, code:1${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
              ) 9
            )
          );

        # plugins = [
        #   packages.${pkgs.system}.hyprbars
        # ];
      };
    };
  };
}
