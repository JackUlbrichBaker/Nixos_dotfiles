{ config, inputs, pkgs, lib, ... }: {
  imports = [
    ./kitty.nix
    #./nvim.nix
    ./nixvim.nix
    ./gaming.nix
    ./i3.nix
    ./i3status-rust.nix
    ./picom.nix
    ./terminal.nix
  ];
}
