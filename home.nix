{ config, pkgs, inputs, ... }:


  let
    startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
      ${pkgs.waybar}/bin/waybar &
      ${pkgs.swww}/bin/swww init &
  
      sleep 1
      
      ${pkgs.swww}/bin/swww img ${ /../../home/jack/Pictures/Wallpapers/480807.jpg  } &
    '';
in

{ home.username = "jack";
  home.homeDirectory = "/home/jack";

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };
   imports = [
       inputs.nix-colors.homeManagerModules.default
       ./features
   ];
   colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
  
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
	general = with config.colorScheme.colors; { 
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
	    ",code:72, exec, pamixer 0"

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


  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them
    vim
    #neovim
    neofetch
    nnn # terminal file manager
    firefox

    # archives
    zip
    xz
    unzip
    p7zip

    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    iotop # io monitoring
    git
    gh
    tmux
    wget
    lolcat
    kitty
    alacritty
    gcc
    slack
    cargo
    pamixer

    #rofi
    google-chrome
    spotify
    xorg.xev
    brightnessctl

    rtkit
    swww
    pkgs.catppuccin
    rofi-wayland
    waybar
    dunst
    networkmanagerapplet
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "JackUlbrichBaker";
    userEmail = "jackubaker@gmail.com";
  };


    programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"

      neofetch | lolcat
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
