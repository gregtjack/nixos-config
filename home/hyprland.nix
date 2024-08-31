{
  inputs,
  pkgs,
  ...
}: let
  ss = pkgs.writeShellScript "screenshot" ''
    grim -g "$(slurp -d)" - | wl-copy -t image/png
  '';
  runner = pkgs.writeShellScript "run" ''
    rofi -show drun | xargs hyprctl dispatch exec --
  '';
  clipboard = pkgs.writeShellScript "clipboard" ''
    cliphist list | ${pkgs.tofi}/bin/tofi | cliphist decode | wl-copy
  '';

  play = pkgs.writeShellScript "yt" ''
    ${pkgs.libnotify}/bin/notify-send "Opening video" "$(wl-paste)"
    ${pkgs.mpv}/bin/mpv "$(wl-paste)"
  '';
in {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      monitor = [
        "HDMI-A-1,1920x1080,0x0,1"
        "DP-2,1920x1080@165,1920x0,1"
        "Unknown-1,disable"
      ];

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];

      exec-once = [
        "swww init"
        "hypridle"
        "mako"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "no";
        };
        sensitivity = 0;
      };

      general = {
        gaps_in = 3;
        gaps_out = 6;
        border_size = 2;
        "col.active_border" = "rgba(f2cdcdee) rgba(cba6f7ee) 45deg";
        "col.inactive_border" = "rgba(000000aa)";
        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
          new_optimizations = "on";
          popups = true;
        };
        drop_shadow = "no";
      };

      animations = {
        enabled = "yes";
        bezier = "bz,0.17,0.98,0.17,0.99";
        animation = [
          "windows,1,5,bz"
          "windowsOut,1,7,default,popin 80%"
          "border,1,10,default"
          "borderangle,1,8,default"
          "fade,1,4,default"
          "workspaces,1,5,default"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      gestures.workspace_swipe = "off";

      misc = {
        force_default_wallpaper = -1;
      };

      bind = let
        binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
        main = "SUPER";
        mainb = binding main;
        exec = mainb "exec";
        mainb-shift = binding "${main} SHIFT";
        ws = [1 2 3 4 5 6 7 8 9];
      in
        [
          (exec "Q" "kitty")
          (exec "B" "firefox")
          (mainb "killactive" "C" "")
          (mainb "exit" "M" "")
          (mainb "fullscreen" "F" "0")
          (mainb "togglefloating" "L" "")
          (exec "R" "${runner}")
          (exec "P" "${play}")
          (mainb "movefocus" "left" "l")
          (mainb "movefocus" "right" "r")
          (mainb "movefocus" "up" "u")
          (mainb "movefocus" "down" "d")

          (mainb-shift "exec" "S" "${ss}")

          (mainb "togglespecialworkspace" "A" "magic")
          (mainb-shift "movetoworkspace" "A" "special:magic")
        ]
        # bind workspaces 1-9
        ++ (map (i: mainb "workspace" (toString i) (toString i)) ws)
        ++ (map (i: mainb-shift "movetoworkspace" (toString i) (toString i)) ws);

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
    };
  };
}
