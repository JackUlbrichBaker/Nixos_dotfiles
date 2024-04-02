{ config, pkgs, inputs, ... }:

  let
    startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
      ${pkgs.waybar}/bin/waybar &
      ${pkgs.swww}/bin/swww init &
  
      sleep 1
      
      ${pkgs.swww}/bin/swww img ${ /../../home/jack/Pictures/Wallpapers/480807.jpg  } &
    '';
in

{
  wayland.windowManager.hyprland = {
    # Whether to enable Hyprland wayland compositor
    enable = true;
    # The hyprland package to use
    package = pkgs.hyprland;
    # Whether to enable XWayland
    xwayland.enable = true;
    extraConfig = ''
    input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =

        follow_mouse = 1

        touchpad {
            natural_scroll = true 
          }


          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      } '';
    # Optional
    # Whether to enable hyprland-session.target on hyprland startup
    systemd.enable = true;
    settings = {
	general = with config.colorScheme.palette; { 
	    "col.active_border" = "rgba(${base0E}ff) rgba(${base09}ff) 60deg";
	    "col.inactive_border" = "rgba(${base00}ff)";
    
    "$mod" = "SUPER";
    
    exec-once = ["[workspace 1 silent] kitty"
    "[workspace 2 silent] firefox"
    "[workspace 3 silent] slack"
    "${startupScript}/bin/start"
    ];

	bind = [
        #"$mod, F, exec, rofi -show drun -show-icons"
            
        ",code:74, exec, pamixer -i 5"
	    ",code:73, exec, pamixer -d 5"
	    ",code:72, exec, pamixer --toggle-mute"

	    ",code:69, exec, brightnessctl s +5% &"
	    ",code:68, exec, brightnessctl s 5% &"

	    "$mod, return, exec, kitty"
	    "$mod, left, movefocus, l"
	    "$mod, right, movefocus, r"
	    "$mod, up, movefocus, u"
	    "$mod, down, movefocus, d"


        "$mod, C, killactive"
        "$mod, S, exec, rofi -show drun"
        "$mod, V, togglefloating"

        
	    ",code:118, exec, grim - | wl-copy"

	]
	      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
	};
    };
  };
}
