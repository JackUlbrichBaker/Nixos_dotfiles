{ config, lib, pkgs, ... }:

with lib;

let 
  mod = "Mod4";
  #cfg = config.default.i3;
  i3StatusBarConfig = ''
    general {
      colors = true
      interval = 1
      outpur_format = i3bar
      color_good = "#8c7f22"
      color_degraded = "#8c7f22
      color_bad = "#be2422"
    }
    order += "disk /"
    order += "wireless wlp2s0"
    order += "cpu_usage"
    order += "battery 0"
    order += "volume master"
    order += "tztime local"

    tztime local {
      format = " Date: %d/%m/%y Time: %H:%M "
    }

    cpu_usage {
      format = " CPU: %usage "
    }
    
    disk "/" {
      format = " Disk: %free "
    }

    volume master {
      format = " Vol: %volume "
      device = "default"
      mixer = "Master"
      mixer_idx = 0
    }

  '';
in {
  xsession.windowManager.i3 = {
    enable = true;
      #modifier = mod;
      package = pkgs.i3-gaps;

    config = {
#      profiles.x11 = {
#        enable = true;
#        compositor = mkDefault true;
#        displayManager = true;
#     };

      keybindings = {
#        "${mod}+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";
#        "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
#        "${mod}+Shift+x" = "exec sh -c '${pkgs.i3lock}/bin/i3lock -c 222222 & sleep 5 && xset dpms force of'";
# Focus

        "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";
        "${mod}+j" = "focus left";
        "${mod}+k" = "focus down";
        "${mod}+l" = "focus up";
        "${mod}+semicolon" = "focus right";

        # Move
        "${mod}+Shift+j" = "move left";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+l" = "move up";
        "${mod}+Shift+semicolon" = "move right";

        # My multi monitor setup
        "${mod}+m" = "move workspace to output DP-2";
        "${mod}+Shift+m" = "move workspace to output DP-5";
      };

      #};

      services.xserver.windowManager.default = mkDefault "i3";
      services.xserver.windowManager.i3 = {
        enable = mkDefault true;
        extraSessionCommands = ''
        ${pkgs.dunst}/bin/dunst &
        '';
        configFile = pkgs.writeText "i3.cfg" ''

        bindsym $mod+1 workspace number "1" 
        bindsym $mod+2 workspace number "2" 
        bindsym $mod+3 workspace number "3" 
        bindsym $mod+4 workspace number "4" 
        bindsym $mod+5 workspace number "5" 
        bindsym $mod+6 workspace number "6" 
        bindsym $mod+7 workspace number "7" 
        bindsym $mod+8 workspace number "8" 
        bindsym $mod+9 workspace number "9" 
        bindsym $mod+10 workspace number "10" 

        bindsym $mod+Shift+1 move container to workspace number $ws1
        bindsym $mod+Shift+2 move container to workspace number $ws2
        bindsym $mod+Shift+3 move container to workspace number $ws3
        bindsym $mod+Shift+4 move container to workspace number $ws4
        bindsym $mod+Shift+5 move container to workspace number $ws5
        bindsym $mod+Shift+6 move container to workspace number $ws6
        bindsym $mod+Shift+7 move container to workspace number $ws7
        bindsym $mod+Shift+8 move container to workspace number $ws8
        bindsym $mod+Shift+9 move container to workspace number $ws9
        bindsym $mod+Shift+10 move container to workspace number $ws10

      bar
        {
          position = "bottom";
          statusCommand = "${i3status}/bin/i3status -c ${
            writeText "i3status-config" i3StatusBarConfig
          }
        }
        '';
  };
};
};
}
