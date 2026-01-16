{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = [",2560x1440@144,0x0,1"];
    };

    general = {
      "$modifier" = "SUPER";
      gaps_in = 6;
      gaps_out = 8;
      border_size = 2;
      resize_on_border = false;
      allow_tearing = true;
      layout = "dwindle";
      "cols.active_border" = "rgba(ccbeffff)";
      "cols.inactive_border" = "rgba(48454eff)";
    };

    decoration = {
      rounding = 8;
      rounding_power = 2;

      # Change transparency of focused and unfocused windows
      active_opacitty = 0.9;
      inactive_opacity = 0.7;
      fullscreen_opacity = 1.0;

      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        color = "rgba(1a1a1aee)";
      };

      blur = {
        enabled = true;
        size = 8;
        passes = 2;
        ignore_opacity = true;
        vibrancy = 0.2;
        noise = 0.0;
        contrast = 1.0;
      };
      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, once"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
      };
      master = {
        new_status = "master";
      };
      misc = {
        layers_hog_keyboard_focus = true;
        initial_workspace_tracking = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        enable_swallow = false;
        vfr = true; # Variable Frame Rate
        vrr = 2; # Variable Refresh Rate  Might need to set to 0 for NVIDIA/AQ_DRM_DEVICES
        # Screen flashing to black momentarily or going black when app is fullscreen
        # Try setting vrr to 0

        #  Application not responding (ANR) settings
        enable_anr_dialog = true;
        anr_missed_pings = 15;
      };
      ecosystem = {
        no_donation_nag = true;
        no_update_news = false;
      };
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";

        touchpad = {
          natural_scroll = false;
        };
      };
      cursor = {
        sync_gsettings_theme = true;
        no_hardware_cursors = 2; # change to 1 if want to disable
        enable_hyprcursor = false;
        warp_on_change_workspace = 2;
        no_warps = true;
      };
      xwayland = {
        force_zero_scaling = true;
      };
    };
  };
}
