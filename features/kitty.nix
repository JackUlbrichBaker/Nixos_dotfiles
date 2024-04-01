{ pkgs, config, ... }: {


  programs = {
    kitty = {
      enable = true;
      settings = {
        foreground = "#${config.colorScheme.palette.base05}";
        background = "#${config.colorScheme.palette.base00}";

        cursor = "#${config.colorscheme.palette.base06}";
        cursor_text_color = "#${config.colorscheme.palette.base00}";
        
        color0 = "#${config.colorScheme.palette.base03}";
        color1 = "#${config.colorScheme.palette.base08}";
        color2 = "#${config.colorScheme.palette.base0B}";
        color3 = "#${config.colorScheme.palette.base0A}";
        color4 = "#${config.colorScheme.palette.base0D}";
        color5 = "#${config.colorScheme.palette.base09}";
        color6 = "#${config.colorScheme.palette.base0C}";
        color7 = "#${config.colorScheme.palette.base05}";
        color8 = "#${config.colorScheme.palette.base04}";
        color9 = "#${config.colorScheme.palette.base08}";
        color10 = "#${config.colorScheme.palette.base0B}";
        color11 = "#${config.colorScheme.palette.base0A}";
        color12 = "#${config.colorScheme.palette.base0D}";
        color13 = "#${config.colorScheme.palette.base09}";
        color14 = "#${config.colorScheme.palette.base0C}";
        color15 = "#${config.colorScheme.palette.base0E}";
      };
    };
  };
}
