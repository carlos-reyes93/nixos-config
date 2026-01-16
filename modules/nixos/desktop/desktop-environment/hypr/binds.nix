{pkgs, ...}: let
  terminal = pkgs.foot;
  menu = pkgs.fuzzel;
in {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$modifier, Return, exec, ${terminal}"
      "$modifier, SPACE, exec, ${menu}"
      "$modifier, W, killactive"
      "$modifier, h, movefocus, l"
      "$modifier, l, movefocus, r"
      "$modifier, k, movefocus, u"
      "$modifier, j, movefocus, d"
      "$modifier, F, fullscreen"
      # Example special workspace (scratchpad)
      "$modifier, O, togglespecialworkspace, magic"
      "$modifier SHIFT, O, movetoworkspace, special:magic"
      # Scroll through existing workspaces with mainMod + scroll
      "$modifier, mouse_down, workspace, e+1"
      "$modifier, mouse_up, workspace, e-1"
    ];
  };
}
