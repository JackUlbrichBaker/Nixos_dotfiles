{ pkgs, lib, ... }:
{
  services.picom = {
    enable = true;

    activeOpacity = 1.0;
    inactiveOpacity = 0.8;
    fade = true;

    opacityRules = [ "100:class_g *?= 'Rofi'" ];
    #settings = builtins.readFile ./picom.conf;
    settings = {
      xrender-sync-fence = true;
      mark-ovredir-focused = false;
      use-ewmh-active-win = true;

      unredir-if-possible = false;
      backend = "xrender"; # try "glx" if xrender doesn't help
      vsync = true;
    };
#    settings = ''
#      corner-radius = 8;
#      rounded-corners-exclude = [
#        "class_i = 'polybar'"
#      ];
#    '';
  };
}
