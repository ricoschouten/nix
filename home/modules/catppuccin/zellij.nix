{ lib, config, ... }:

let
  inherit (lib) mkIf;
    
  color.mocha = {
    rosewater = "#f5e0dc";
    flamingo = "#f2cdcd";
    pink = "#f5c2e7";
    mauve = "#cba6f7";
    red = "#f38ba8";
    maroon = "#eba0ac";
    peach = "#fab387";
    yellow = "#f9e2af";
    green = "#a6e3a1";
    teal = "#94e2d5";
    sky = "#89dceb";
    sapphire = "#74c7ec";
    blue = "#89b4fa";
    lavender = "#b4befe";
    text = "#cdd6f4";
    subtext1 = "#bac2de";
    subtext0 = "#a6adc8";
    overlay2 = "#9399b2";
    overlay1 = "#7f849c";
    overlay0 = "#6c7086";
    surface2 = "#585b70";
    surface1 = "#45475a";
    surface0 = "#313244";
    base = "#1e1e2e";
    mantle = "#181825";
    crust = "#11111b";
  };

  color.latte = {
    rosewater = "#dc8a78";
    flamingo = "#dd7878";
    pink = "#ea76cb";
    mauve = "#8839ef";
    red = "#d20f39";
    maroon = "#e64553";
    peach = "#fe640b";
    yellow = "#df8e1d";
    green = "#40a02b";
    teal = "#179299";
    sky = "#04a5e5";
    sapphire = "#209fb5";
    blue = "#1e66f5";
    lavender = "#7287fd";
    text = "#4c4f69";
    subtext1 = "#5c5f77";
    subtext0 = "#6c6f85";
    overlay2 = "#7c7f93";
    overlay1 = "#8c8fa1";
    overlay0 = "#9ca0b0";
    surface2 = "#acb0be";
    surface1 = "#bcc0cc";
    surface0 = "#ccd0da";
    base = "#eff1f5";
    mantle = "#e6e9ef";
    crust = "#dce0e8";
  };

  color.frappe = {    
    rosewater = "#f2d5cf";
    flamingo = "#eebebe";
    pink = "#f4b8e4";
    mauve = "#ca9ee6";
    red = "#e78284";
    maroon = "#ea999c";
    peach = "#ef9f76";
    yellow = "#e5c890";
    green = "#a6d189";
    teal = "#81c8be";
    sky = "#99d1db";
    sapphire = "#85c1dc";
    blue = "#8caaee";
    lavender = "#babbf1";
    text = "#c6d0f5";
    subtext1 = "#b5bfe2";
    subtext0 = "#a5adce";
    overlay2 = "#949cbb";
    overlay1 = "#838ba7";
    overlay0 = "#737994";
    surface2 = "#626880";
    surface1 = "#51576d";
    surface0 = "#414559";
    base = "#303446";
    mantle = "#292c3c";
    crust = "#232634";
  };

  color.macchiato = {    
    rosewater = "#f4dbd6";
    flamingo = "#f0c6c6";
    pink = "#f5bde6";
    mauve = "#c6a0f6";
    red = "#ed8796";
    maroon = "#ee99a0";
    peach = "#f5a97f";
    yellow = "#eed49f";
    green = "#a6da95";
    teal = "#8bd5ca";
    sky = "#91d7e3";
    sapphire = "#7dc4e4";
    blue = "#8aadf4";
    lavender = "#b7bdf8";
    text = "#cad3f5";
    subtext1 = "#b8c0e0";
    subtext0 = "#a5adcb";
    overlay2 = "#939ab7";
    overlay1 = "#8087a2";
    overlay0 = "#6e738d";
    surface2 = "#5b6078";
    surface1 = "#494d64";
    surface0 = "#363a4f";
    base = "#24273a";
    mantle = "#1e2030";
    crust = "#181926";
  };
in
{
  programs.zellij.zjstatus = with config.programs.zellij; mkIf (enable) {
    color = color.${catppuccin.flavor};

    format = {
      left = "#[bg=$surface0,fg=$sapphire]#[bg=$sapphire,fg=$crust,bold] {session} #[bg=$surface0] {mode}#[bg=$surface0] {tabs}";
      center = "{notifications}";
      right = "#[bg=$surface0,fg=$flamingo]#[fg=$crust,bg=$flamingo] #[bg=$surface1,fg=$flamingo,bold] {command_user}@{command_host}#[bg=$surface0,fg=$surface1]#[bg=$surface0,fg=$maroon]#[bg=$maroon,fg=$crust]󰃭 #[bg=$surface1,fg=$maroon,bold] {datetime}#[bg=$surface0,fg=$surface1]";
      space = "#[bg=$surface0]";
      hide-on-overlength = true;
      precedence = "lrc";
    };

    border = {
      enabled = false;
      char = "─";
      format = "#[bg=$surface0]{char}";
      position = "top";
    };

    mode = {
      normal = "#[bg=$green,fg=$crust,bold]  #[bg=$surface0,fg=$green]";
      tmux = "#[bg=$mauve,fg=$crust,bold]  #[bg=$surface0,fg=$mauve]";
      locked = "#[bg=$red,fg=$crust,bold]  #[bg=$surface0,fg=$red]";
      pane = "#[bg=$teal,fg=$crust,bold]  #[bg=$surface0,fg=$teal]";
      tab = "#[bg=$teal,fg=$crust,bold]  #[bg=$surface0,fg=$teal]";
      scroll = "#[bg=$flamingo,fg=$crust,bold]  #[bg=$surface0,fg=$flamingo]";
      enter-search = "#[bg=$flamingo,fg=$crust,bold]  #[bg=$surfaco,fg=$flamingo]";
      search = "#[bg=$flamingo,fg=$crust,bold]  #[bg=$surfac0,fg=$flamingo]";
      resize = "#[bg=$yellow,fg=$crust,bold]  #[bg=$surfac0,fg=$yellow]";
      rename-tab = "#[bg=$yellow,fg=$crust,bold]  #[bg=$surface0,fg=$yellow]";
      rename-pane = "#[bg=$yellow,fg=$crust,bold]  #[bg=$surface0,fg=$yellow]";
      move = "#[bg=$yellow,fg=$crust,bold]  #[bg=$surface0,fg=$yellow]";
      session = "#[bg=$pink,fg=$crust,bold]  #[bg=$surface0,fg=$pink]";
      prompt = "#[bg=$pink,fg=$crust,bold]  #[bg=$surface0,fg=$pink]";
    };

    tab = {
      normal = "#[bg=$surface0,fg=$blue]#[bg=$blue,fg=$crust,bold]{index} #[bg=$surface1,fg=$blue,bold] {name}{floating_indicator}#[bg=$surface0,fg=$surface1]";
      normal-fullscreen = "#[bg=$surface0,fg=$blue]#[bg=$blue,fg=$crust,bold]{index} #[bg=$surface1,fg=$blue,bold] {name}{fullscreen_indicator}#[bg=$surface0,fg=$surface1]";
      normal-sync = "#[bg=$surface0,fg=$blue]#[bg=$blue,fg=$crust,bold]{index} #[bg=$surface1,fg=$blue,bold] {name}{sync_indicator}#[bg=$surface0,fg=$surface1]";
      active = "#[bg=$surface0,fg=$peach]#[bg=$peach,fg=$crust,bold]{index} #[bg=$surface1,fg=$peach,bold] {name}{floating_indicator}#[bg=$surface0,fg=$surface1]";
      active-fullscreen = "#[bg=$surface0,fg=$peach]#[bg=$peach,fg=$crust,bold]{index} #[bg=$surface1,fg=$peach,bold] {name}{fullscreen_indicator}#[bg=$surface0,fg=$surface1]";
      active-sync = "#[bg=$surface0,fg=$peach]#[bg=$peach,fg=$crust,bold]{index} #[bg=$surface1,fg=$peach,bold] {name}{sync_indicator}#[bg=$surface0,fg=$surface1]";
      separator = "#[bg=$surface0] ";

      sync-indicator = " ";
      fullscreen-indicator = " 󰊓";
      floating-indicator = " 󰹙";
    };

    notification = {
      format-unread = "#[bg=surface0,fg=$yellow]#[bg=$yellow,fg=$crust] #[bg=$surface1,fg=$yellow] {message}#[bg=$surface0,fg=$yellow]";
      format-no-notifications = "";
      show-interval = 10;
    };

    command = {
      "host" = {
        command = "uname -n";
        format = "{stdout}";
        interval = 0;
        rendermode = "static";
      };

      "user" = {
        command = "whoami";
        format = "{stdout}";
        interval = 10;
        rendermode = "static";
      };
    };
    
    datetime = "{format}";
    datetime-format = "%d/%m 󰅐 %H:%M";
    datetime-timezone = "Europe/Amsterdam";
  };
}

