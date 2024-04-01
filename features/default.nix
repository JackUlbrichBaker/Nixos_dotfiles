{ config, inputs, pkgs, lib, ... }: {
  imports = [
    ./kitty.nix
    ./nvim.nix
    ./hyprland.nix
  ];
}
