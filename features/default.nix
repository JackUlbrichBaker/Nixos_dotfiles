{ config, inputs, pkgs, lib, ... }: {
  imports = [
    ./kitty.nix
    #./nvim.nix
    ./nixvim.nix
    ./i3.nix
    ./picom.nix
    ./polybar/polybar.nix
    ./terminal.nix
  ];
}
