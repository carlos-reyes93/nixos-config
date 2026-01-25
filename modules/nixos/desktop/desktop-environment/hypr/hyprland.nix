{config, ...}: {
  home-manager.users.${config.charly.user.name} = {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$modifier" = "SUPER";

        monitor = [",2560x1440@144,0x0,1"];

        general = {
          gaps_in = 6;
          gaps_out = 8;
          border_size = 2;
          resize_on_border = false;
          allow_tearing = true;
          layout = "dwindle";
          "col.active_border" = "rgba(ccbeffff)";
          "col.inactive_border" = "rgba(48454eff)";
        };

        decoration = {
          rounding = 8;
          rounding_power = 2;
          active_opacity = 0.9;
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
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          vfr = true;
          vrr = 2;
        };

        input = {
          kb_layout = "us";
          follow_mouse = 1;
          accel_profile = "flat";
        };

        xwayland = {
          force_zero_scaling = true;
        };
      };
    };
  };
}
