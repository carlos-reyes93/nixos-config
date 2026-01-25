{config, ...}: {
  home-manager.users.${config.charly.user.name} = {
    wayland.windowManager.hyprland = {
      settings = {
        windowrulev2 = [
          # -----------------------------
          # Games / Gaming environments
          # -----------------------------

          # Gamescope
          "fullscreen, class:^(gamescope)$"
          "noblur, class:^(gamescope)$"
          "noshadow, class:^(gamescope)$"
          "idleinhibit fullscreen, class:^(gamescope)$"

          # Steam games (launched via Steam)
          "fullscreen, class:^(steam_app_\\d+)$"
          "noblur, class:^(steam_app_\\d+)$"
          "noshadow, class:^(steam_app_\\d+)$"
          "idleinhibit fullscreen, class:^(steam_app_\\d+)$"

          # Steam client itself
          "float, class:^([Ss]team)$, title:negative:^([Ss]team)$"

          # Generic fullscreen idle inhibit (safety net)
          "idleinhibit fullscreen, fullscreen:1"
        ];
      };
    };
  };
}
