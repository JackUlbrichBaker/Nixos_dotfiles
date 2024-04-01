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
