{ lib, config, ... }:

let
  cfg = config.programs.gnome;
in
{
  options.programs.gnome = {
    enable = lib.mkEnableOption "gnome" // {
      description = "Enable GNOME desktop environment";
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
      # xkb.layout = "us";

      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
