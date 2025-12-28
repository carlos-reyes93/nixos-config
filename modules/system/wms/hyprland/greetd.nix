{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkIf types;
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  hyprland-session = "${pkgs.hyprland}/share/wayland-sessions";
  hyprland = inputs.hyprland.packages.${system}.hyprland;
  system = pkgs.stdenv.hostPlatform.system;
  mod = "autologin";
  cfg = config.charly.${mod};
in {
  options.charly.${mod}.enable = mkOption {
    description = mod;
    type = types.bool;
    default = false;
  };
  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${tuigreet} --time --remember --remember-session --sessions ${hyprland-session}";
          user = "greeter";
        };
        initial_session = {
          command = "${hyprland}/bin/Hyprland";
          user = "charly";
        };
      };
    };
  };
}
