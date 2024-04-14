{ config, inputs, pkgs, lib, ... }: {
  imports = [
    ./kitty.nix
    ./nvim.nix
    ./i3.nix
    ./terminal.nix
  ];
}
