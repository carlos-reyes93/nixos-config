{
  config,
  pkgs,
  ...
}: let
  terminal = pkgs.lib.getExe pkgs.foot;
  menu = pkgs.lib.getExe pkgs.fuzzel;
  mkSubmap = {
    name,
    mod,
    key,
    binds,
  }: ''
    bind = ${mod}, ${key}, submap, ${name}
    submap = ${name}
    ${builtins.concatStringsSep "\n" binds}
    bindn = , catchall, submap, reset
    submap = reset
  '';
in {
  home-manager.users.${config.charly.user.name} = {
    wayland.windowManager.hyprland = {
      settings = {
        bind =
          [
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
          ]
          ++ (
            builtins.concatLists (builtins.genList (i: let
                ws = i + 1;
              in [
                "$modifier, ${toString ws}, workspace, ${toString ws}"
                "$modifier SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
              ])
              5)
          );
      };
      extraConfig = builtins.concatStringsSep "\n\n" [
        (mkSubmap {
          name = "launchers";
          mod = "$modifier";
          key = "R";
          binds = [
            "bindn = , t, exec, ~/repos/dotfiles/scripts/fuzzel-tmux-sessions.sh"
            "bindn = , r, exec, ~/repos/dotfiles/scripts/fuzzel-repos.sh"
          ];
        })
        (mkSubmap {
          name = "utils";
          mod = "$modifier";
          key = "U";
          binds = [
            "bindn = , t, togglesplit"
          ];
        })
      ];
    };
  };
}
