{config, ...}: {
  home-manager.users.${config.charly.user.name} = {
    wayland.windowManager.hyprland = {
      settings = {
        windowrule = [
          # -----------------------------
          # Games / Gaming environments
          # -----------------------------

          # Gamescope
          "fullscreen on, match:class ^(gamescope)$"
          "no_blur on, match:class ^(gamescope)$"
          "no_shadow on, match:class ^(gamescope)$"
          "idle_inhibit fullscreen, match:class ^(gamescope)$"

          # Steam games (launched via Steam)
          "fullscreen on, match:class ^(steam_app_\\d+)$"
          "no_blur on, match:class ^(steam_app_\\d+)$"
          "no_shadow on, match:class ^(steam_app_\\d+)$"
          "idle_inhibit fullscreen, match:class ^(steam_app_\\d+)$"

          # Steam client itself
          "float on, match:class ^([Ss]team)$,"
          "tile on, match:class ^([Ss]team)$, match:title ^([Ss]team)$"
        ];
      };
    };
  };
}
