{config, ...}: {
  home-manager.users.${config.charly.user.name} = {
    wayland.windowManager.hyprland = {
      settings = {
        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
          "LIBVA_DRIVER_NAME,nvidia"
          "_GLX_VENDOR_LIBRARY_NAME,nvidia"
          "HYPRCURSOR_THEME,rose-pine-hyprcursor"
          "QT_QPA_PLATFORM,wayland;xcb"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "IBVA_DRIVER_NAME,nvidia"
        ];
      };
    };
  };
}
