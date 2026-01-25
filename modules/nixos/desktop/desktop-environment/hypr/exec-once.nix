{config, ...}: let
in {
  home-manager.users.${config.charly.user.name} = {
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "noctalia-shell"
        "swww-daemon"
        "tmux setenv -g HYPRLAND_INSTANCE_SIGNATURE \"$HYPRLAND_INSTANCE_SIGNATURE\""
        "wl-paste --type text --watch cliphist store" # Saves text
        "wl-paste --type image --watch cliphist store" # Saves images
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user start hyprpolkitagent"
      ];
    };
  };
}
