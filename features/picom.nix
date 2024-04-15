{ pkgs, lib, ... }:
{
  services.picom = {
    enable = true;

    activeOpacity = 1.0;
    inactiveOpacity = 0.8;
    fade = true;

    opacityRules = [ "100:class_g *?= 'Rofi'" ];
    picom.settings = builtins.readFile ./picom.conf;

#    settings = ''
#      corner-radius = 8;
#      rounded-corners-exclude = [
#        "class_i = 'polybar'"
#      ];
#    '';
  };
}
