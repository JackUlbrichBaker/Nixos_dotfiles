{ pkgs, lib, config, ... }:
{
programs.i3status-rust = {
  enable = true;
  bars = {
    default = {
      blocks = [
	  {
	     block = "disk_space";
	     path = "/";
	     info_type = "available";
	     interval = 60;
	     warning = 20.0;
	     alert = 10.0;
	   }
	   {
	     block = "battery";
	     interval = 1;
             format = " $icon $percentage " ;
	     #path = "/sys/class/power_supply/BAT%d/uevent";
	     }
	   {
	     block = "net";
	     format = " $icon {$ssid $frequency|Wired connection} via $device ";
	   }
	   {
	     block = "cpu";
	     interval = 1;
	   }
	   {
	     block = "load";
	     interval = 1;
	     format = " $icon $1m ";
	   }
	   { block = "sound"; }
	   {
	     block = "time";
	     interval = 60;
	     format = " $timestamp.datetime(f:'%a %d/%m %R') ";
	   }
	];
  icons = "awesome5";
  theme = "gruvbox-dark";
      };
    };
 };
}
