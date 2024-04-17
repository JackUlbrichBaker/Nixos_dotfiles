{ pkgs, lib, config, ... }:

{
  xsession.windowManager.i3 = { 
    enable = true;
    package = pkgs.i3-gaps;

    config = rec {
      modifier = "Mod4";
      
      workspaceLayout = "default";

      bars = [ 
      {
	position = "bottom";
	colors = {
	  background = "#${config.colorScheme.palette.base01}";
	  focusedWorkspace = {
	    background = "#${config.colorScheme.palette.base0B}";
	    border = "#${config.colorScheme.palette.base00}";
	    text = "#${config.colorScheme.palette.base01}";
	  };
	};
	}
      ];
      #window.border = 2;
      window = {
	border = 2;
	titlebar = false;
      };
      gaps = {
	  inner = 15;
	  outer = 5;
	};

      assigns = {
	"2: " = [{ class = "^Firefox$"; }];
	"3: " = [{ class = "^Slack$"; }];
      };
      keybindings = lib.mkOptionDefault {
        "XF86AudioMute" = "exec amixer set Master toggle";
        "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
        "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 4%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 4%+";
        "${modifier}+Return" = "exec ${pkgs.kitty}/bin/kitty";
        "${modifier}+s" = "exec ${pkgs.rofi}/bin/rofi -modi drun -show drun"; "${modifier}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi -show window";
        "${modifier}+b" = "exec ${pkgs.google-chrome}/bin/google-chrome-stable";
        "${modifier}+Shift+x" = "exec systemctl suspend";
        "${modifier}+c" = "kill";
      
      };

      startup = [
        {
          command = "exec i3-msg workspace 1";
          always = true;
          notification = false;
        }
        { command = "exec kitty";
          always = true;
          notification = false;
        }
        {
          command = "exec i3-msg exec firefox'";
          always = true;
          notification = false;
        }
        {
          command = "exec i3-msg exec slack'";
          always = true;
          notification = false;
        }
      ];
      colors = {
	background = "#${config.colorScheme.palette.base01}"; 
	
	focused = {
	  background = "#${config.colorScheme.palette.base01}"; 
	  border = "#${config.colorScheme.palette.base0B}";
	  childBorder = "#${config.colorScheme.palette.base0B}";
	  indicator = "#${config.colorScheme.palette.base0B}";
	  text = "#${config.colorScheme.palette.base01}";
	};
	
	unfocused = {
	  background = "#${config.colorScheme.palette.base00}"; 
	  border = "#${config.colorScheme.palette.base00}";
	  childBorder = "#${config.colorScheme.palette.base00}";
	  indicator = "#${config.colorScheme.palette.base04}";
	  text = "#${config.colorScheme.palette.base05}";
	};

      };
    

    };
    extraConfig = "new_window pixel";
  };
}
