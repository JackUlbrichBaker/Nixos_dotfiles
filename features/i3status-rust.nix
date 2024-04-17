{ pkgs, lib, config, ... }:
{
programs.i3status-rust = {
  enable = true;
  enableDefault = true;
  bars.theme = "gruvbox-dark";
 };
}
