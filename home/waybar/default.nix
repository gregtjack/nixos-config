{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        margin = "5px";
        modules-left = [
          "hyprland/workspaces"
          "hyprland/mode"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "pulseaudio"
          "tray"
          "network"
          "clock#time"
        ];

        "network" = {
          "interval" = 5;
          "format-wifi" = "  {essid} ({signalStrength}%)";
          "format-ethernet" = "󰈀  {ifname}";
          "format-disconnected" = "⚠  Disconnected";
          "tooltip-format" = "{ifname}: {ipaddr}/{cidr}\n{bandwidthUpBits} Tx | {bandwidthDownBits} Rx";
        };

        "clock#time" = {
          "interval" = 1;
          "format" = "{:%I:%M %p}";
          "tooltip" = false;
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-bluetooth = "{icon}  {volume}% ";
          format-muted = "";
          format-icons = {
            "default" = ["" ""];
          };
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
      };
    };
  };
}
