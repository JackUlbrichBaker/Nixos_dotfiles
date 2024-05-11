{ lib, config, pkgs, inputs, ... }:

let
  inherit (lib) types mkOption;
in {

 home.username = "jack"; home.homeDirectory = "/home/jack";

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 96; }; 
    #"Xft.dpi" = 172; }; 
    imports = [
      inputs.nix-colors.homeManagerModules.default
      inputs.nixvim.homeManagerModules.nixvim
       ./features
   ];
   colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;
   


  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them
    vim
    #neovim
    neofetch
    nnn # terminal file manager
    firefox
    ripgrep
    kicad
    #i3
    picom
    maim
    xclip
    xdotool
    obsidian
    autotiling

    # archives
    zip
    xz
    unzip
    p7zip
    kdePackages.dolphin
    libsForQt5.partitionmanager

    python3
    gtk3
    python312Packages.numpy
    python312Packages.pysearpc
    rubyPackages_3_3.gdk_pixbuf2
    lua

    #wayland
    #hyprland
    hyprlock

    swappy
    grim
    wl-clipboard

    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses
    nix-output-monitor

    # Programming tools
    stm32flash
    stm32loader
    stm32cubemx

    openfpgaloader
    quartus-prime-lite
    nextpnr

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal
    doomretro

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
    nix-output-monitor

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
    rustc
    crate2nix
    rust-analyzer

    #rofi
    google-chrome
    spotify
    xorg.xev
    brightnessctl
    zoom-us

    rtkit
    swww
    pkgs.catppuccin
    rofi-wayland
    waybar
    dunst
    networkmanagerapplet
    pipes
    cbonsai
    tree
    pcre
  ];

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
